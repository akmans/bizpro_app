module PcMapsHelper
  def pc_map_custom_cnt_help(product_id)
    PcMap.where(product_id: product_id).count
  end
end