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
end
