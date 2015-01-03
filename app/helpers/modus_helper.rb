#encoding: utf-8
module ModusHelper
  # return modu name by modu id
  def modu_name_help(modu_id)
    (Modu.find(modu_id).modu_name if Modu.exists?(modu_id)) || '-'
  end

  # return modu hash
  def modu_hash_help
    modus = {"" => "(空白)"}
    Modu.all.each do |mm| 
      modus.merge! mm.as_hash
    end
    return modus
  end
end