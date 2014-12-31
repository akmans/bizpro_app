#encoding: utf-8
module ProductsHelper

  # is_domestic_hash
  def is_domestic_hash
    {"0" => "海外", "1" => "国内"}
  end

  # is_domestic_name
  def is_domestic_name(key)
    key.blank? ? "-" : is_domestic_hash[key.to_s]
  end

  def products_hash
    p_hash = {"" => "(空白)"}
    Product.all.each do |product|
      akey = product.product_id
      avalue = product.product_name
      new_hash = { akey => avalue}
      p_hash.merge! new_hash
    end
    p_hash
  end
end
