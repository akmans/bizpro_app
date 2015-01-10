module SoldsHelper
  def sold_cnt_help(product_id)
    Sold.where(product_id: product_id).count
  end
end
