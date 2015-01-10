class Sold < ActiveRecord::Base

  default_scope -> { order(sold_date: :DESC) }

  validates :product_id , presence: true ,length: { maximum: 20}
  validates :sold_date , presence: true
  validates :sold_price, numericality: true, presence: true
  validates :ship_charge, numericality: true, allow_blank: true
  validates :other_charge, numericality: true, allow_blank: true
  validates :memo, length: { maximum: 200}, allow_blank: true

end