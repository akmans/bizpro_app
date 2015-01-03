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

  # shipmethod name help
  def shipmethod_name_help(shipmethod_id)
    (Shipmethod.find(shipmethod_id).shipmethod_name if Shipmethod.exists?(shipmethod_id)) || '-'
  end

  # shipmethod hash help
  def shipmethod_hash_help
    shipmethods = {"" => "(空白)"}
    Shipmethod.all.each do |ss| 
      shipmethods.merge! ss.as_hash
    end
    return shipmethods
  end
end