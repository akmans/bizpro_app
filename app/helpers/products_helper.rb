#encoding: utf-8
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
  def product_total_cost_help(auctions, customs, shipment_details)
    total = 0
    if !auctions.nil?
      auctions.each do |a|
        total += auction_total_cost_help(a)
      end
    end
    if !customs.nil?
      customs.each do |c|
        total += custom_total_cost_help(c)
      end
    end
    if !shipment_details.nil?
      shipment_details.each do |sd|
        total += shipment_product_cost_help(sd)
      end
    end
    return total
  end

  # return product total sold price
  def product_total_sold_price_help(solds)
    total = 0
    if !solds.nil?
      solds.each do |s|
        total += sold_total_price_help(s)
      end
    end
    return total
  end

  # return profit
  def profit_help(product, auctions, customs, shipment_details, solds)
    product_total_sold_price_help(solds) + product_total_cost_help(auctions, customs, shipment_details) * \
    (product.exchange_rate || 8.3) / 100
  end

  # return profit rate
  def profit_rate_help(product, auctions, customs, shipment_details, solds)
    profit_help(product, auctions, customs, shipment_details, solds) / \
      product_total_sold_price_help(auctions, customs, shipment_details) * 100
  end
end
