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
  def products_hash_help
    p_hash = {"" => "(空白)"}
    Product.where(is_domestic: 2).each do |product|
      akey = product.product_id
      avalue = product.product_name
      new_hash = { akey => avalue}
      p_hash.merge! new_hash
    end
    p_hash
  end
end
