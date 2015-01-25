#encoding: utf-8
module PaMapsHelper
  # return pa_map count
  def pa_map_auction_cnt_help(product_id)
    PaMap.where(product_id: product_id).count
  end
end
