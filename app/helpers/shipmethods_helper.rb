#encoding: utf-8
module ShipmethodsHelper
  
  # shipmethod_type_hash
  def shipmethod_type_hash
    {"0" => "国内", "1" => "海外"}
  end
  
  # shipmethod_type_name
  def shipmethod_type_name(key)
    key.blank? ? "-" : shipmethod_type_hash[key.to_s]
  end
end
