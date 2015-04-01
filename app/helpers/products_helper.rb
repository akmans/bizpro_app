#encoding: utf-8
include CustomsHelper, ShipmentDetailsHelper, SoldsHelper

module ProductsHelper

  # return is domestic hash
  def is_domestic_hash_help
    {"0" => "海外", "1" => "国内", "2" => "発送中"}
  end

  # return is domestic name by key
  def is_domestic_name_help(key)
    key.blank? ? "-" : is_domestic_hash_help[key.to_s]
  end

  # return product name by product id
  def product_name_help(product_id)
    (Product.find(product_id).product_name if Product.exists?(product_id)) || '-'
  end

  # return products hash
  def products_hash_help(product_id = nil)
    p_hash = {"" => "(空白)"}
    Product.where(is_domestic: 2).each do |product|
      akey = product.product_id
      avalue = product.product_name
      new_hash = { akey => avalue}
      p_hash.merge! new_hash
    end
    if !product_id.nil? && !p_hash.has_key?(product_id)
      exist_hash = { product_id => Product.find(product_id).product_name }
    end
    p_hash.merge! exist_hash unless exist_hash.nil?
    return p_hash
  end

  # return product total cost
  def product_total_cost_help(product_id)
    total = 0
    return total if product_id.nil?
    # get auction data
    auctions = Auction.where(:auction_id => PaMap.where(product_id: product_id)).where(sold_flg: 0).all
    # get custom data
    customs = Custom.where(:custom_id => PcMap.where(product_id: product_id)).all
    # get shipment data
    shipment_details = ShipmentDetail.where(product_id: product_id).all
    # auctions cost
    if !auctions.nil?
      auctions.each do |a|
        total += auction_total_cost_help(a)
      end
    end
    # customs cost
    if !customs.nil?
      customs.each do |c|
        total += custom_total_cost_help(c.custom_id)
      end
    end
    # shipment details cost
    if !shipment_details.nil?
      shipment_details.each do |sd|
        total += shipment_product_cost_help(sd)
      end
    end
    return total
  end

  # return profit hash
  def profit_hash_help(product_id)
      info = {}
      # get product
      product = Product.where(product_id: product_id).first
      # amount(bought) function defined at application helper
      cost = cost_calculate({"product_id" => product.product_id, \
          "is_domestic" => product.is_domestic}, nil, nil)
      info["cost_amount"] = -1 * cost["amount"]
      info["cost_amount_jp"] = (info["cost_amount"] || 0) if product.is_domestic == 1
      info["cost_amount_jp"] = (info["cost_amount"] || 0) * 100 / (product.exchange_rate || 100) \
          unless product.is_domestic == 1
      # sold count
      cnt = Product.where(product_id: product_id).where.not(sold_date: nil).count
      if cnt == 0
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(demestic sold)
        info["sold_amount"] = Auction.select("SUM(price * (tax_rate + 100) / 100 - " \
            + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) as amount") \
            .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
            .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
            .where("products.product_id = :product_id", {:product_id => product_id}) \
            .where(sold_flg: 1).reorder('').first.amount.to_f if product.is_domestic == 1
        # amount(offshore sold)
        info["sold_amount"] = Sold.select("SUM(COALESCE(sold_price, 0))" \
            + " - SUM(COALESCE(ship_charge, 0)) - SUM(COALESCE(other_charge, 0)) as amount") \
            .joins("LEFT JOIN products ON solds.product_id = products.product_id") \
            .where("products.product_id = :product_id", {:product_id => product_id}) \
            .reorder('').first.amount.to_f if product.is_domestic == 0
        # profit amount
        info["profit_amount"] = info["sold_amount"] + info["cost_amount"]
        # profit rate
        info["profit_rate"] = (info["cost_amount"] != 0 ? (info["profit_amount"] * 100 / info["cost_amount"]).round(2) * -1 : 0)
      end
      return info
  end
end
