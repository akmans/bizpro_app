module SoldsHelper
  # return sold count
  def sold_cnt_help(product_id)
    Sold.where(product_id: product_id).count
  end

  # return sold total price
  def sold_total_price_help(sold)
    sold.sold_price - (sold.ship_charge || 0) - (sold.other_charge || 0)
  end
end
