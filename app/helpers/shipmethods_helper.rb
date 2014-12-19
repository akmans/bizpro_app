#encoding: utf-8
module ShipmethodsHelper
  
  # ship_type_hash
  def ship_type_hash
    {"0" => "国内", "1" => "海外"}
  end
  
  # ship_type_name
  def ship_type_name(key)
    key.blank? ? "-" : ship_type_hash[key.to_s]
  end
end
