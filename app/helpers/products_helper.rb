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

  # return product total sold price
#  def product_total_sold_price_help(product_id)
#    total = 0
#    return total if product_id.nil?
#    product = Product.find(product_id)
#    if (product.is_domestic || 0) == 1
#     # get auction data
#      auctions = Auction.where(:auction_id => PaMap.where(product_id: product_id)).where(sold_flg: 1).all
#      # auctions cost
#      if !auctions.nil?
#        auctions.each do |a|
#          total += auction_total_cost_help(a)
#        end
#      end
#    else
#      # get sold data
#      solds = Sold.where(product_id: product_id)
#      # sold total value
#      if !solds.nil?
#        solds.each do |s|
#          total += sold_total_price_help(s)
#        end
#      end
#    end
#    return total
#  end

  # return profit
#  def profit_help(product_id)
#    total = 0
#    return total if product_id.nil?
#    product = Product.find(product_id)
#    rate = (product.is_domestic == '1' ? (product.exchange_rate || 8.3) : 100)
#    total = product_total_sold_price_help(product_id) + \
#            product_total_cost_help(product_id) * rate / 100
#    return total.to_f
#  end

  # return profit rate
#  def profit_rate_help(product_id)
#    total = 0
#    return total if product_id.nil?
#    product = Product.find(product_id)
#    rate = (product.is_domestic == '1' ? (product.exchange_rate || 8.3) : 100)
#    total = profit_help(product_id) * -100 * 100 / \
#            (product_total_cost_help(product_id) * rate)
#  end

  # return profit hash
  def profit_hash_help(product_id)
      info = {}
      # get product
      product = Product.where(product_id: product_id).first
      # amount(bought) (sold_flg, date_type, is_domestic)
      info["cost_amount"] = cost_calculate(product_id, product.is_domestic)
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

  # cost calculate
  def cost_calculate(product_id, is_domestic)
    # auction cost
    bought1 = Auction.select("SUM((price * (tax_rate + 100) / 100 - " \
        + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100) as amount") \
        .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
        .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
        .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
#        .where("products.sold_date is not null") \
        .where("products.product_id = :product_id", {:product_id => product_id}) \
        .where(sold_flg: 0).reorder('').first.amount.to_f
    # custom cost(non auction)
    bought2 = Custom.select("SUM((COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) * " \
        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100) as amount") \
        .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
        .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id ") \
        .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
#        .where("products.sold_date is not null") \
        .where("products.product_id = :product_id", {:product_id => product_id}) \
        .where(is_auction: 0).reorder('').first.amount.to_f
    # custom cost(auction)
    bought3 = Custom.select("SUM((price * (tax_rate + 100) / 100 - " \
        + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) * " \
        + "percentage / 100 / 100) as amount") \
        .joins("LEFT JOIN auctions ON customs.auction_id = auctions.auction_id ") \
        .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
        .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id") \
        .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
#        .where("products.sold_date is not null") \
        .where("products.product_id = :product_id", {:product_id => product_id}) \
        .where(is_auction: 1).reorder('').first.amount.to_f
    # offshore shipment cost
    bought4 = ShipmentDetail.select("SUM((COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0) + " \
        + "COALESCE(custom_cost, 0) * 100 / (CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) " \
        + ") * ((CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100)) as amount") \
        .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
        .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
#        .where("products.sold_date is not null") \
        .where("products.product_id = :product_id", {:product_id => product_id}) \
        .reorder('').first.amount.to_f
    return (bought1 + bought2 + bought3 + bought4) * -1
  end
end
