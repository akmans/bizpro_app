class Auction < ActiveRecord::Base
  self.primary_key = "auction_id"
  
  default_scope -> { order(created_at: :DESC) }
  
  validates :auction_id , presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :auction_name, presence: true, length: { maximum: 200}
  validates :price, presence: true, numericality: { only_integer: true }
  validates :seller_id, presence: true, length: { maximum: 50}
  validates :url, length: { maximum: 200}, allow_blank: true
  validates :sold_flg, presence: true,
                       :numericality => { :only_integer => true,
                                          :greater_than_or_equal_to => 0,
                                          :less_than_or_equal_to => 9 }
  validates :is_custom, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 1 }
  validates :category_id , length: { maximum: 4}
  validates :brand_id , length: { maximum: 4}
  validates :modu_id , length: { maximum: 7}
  validates :paymethod_id , length: { maximum: 4}
  validates :payment_cost, numericality: { only_integer: true }, allow_blank: true
  validates :ship_type, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 1 }
  validates :shipmethod_id , length: { maximum: 4}
  validates :shipment_cost, numericality: { only_integer: true }, allow_blank: true
  validates :shipment_code , length: { maximum: 12}
  validates :memo, length: { maximum: 200}, allow_blank: true
end