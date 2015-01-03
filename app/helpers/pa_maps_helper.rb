#encoding: utf-8
module PaMapsHelper
#  def part_type_hash_help
#    {"" => "(空白)", "0" => "カスタム品", "1" => "オークション品"}
#  end
#
#  def part_type_name_help(key)
#    key.blank? ? "-" : part_type_hash_help[key.to_s]
#  end
#
  def pa_map_auction_cnt_help(product_id)
    PaMap.where(product_id: product_id).count
  end
end
