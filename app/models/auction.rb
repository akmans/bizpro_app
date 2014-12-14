class Auction < ActiveRecord::Base
  self.primary_key = "auction_id"
  
  default_scope -> { order(created_at: :ASC) }
  
  validates :auction_id , presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :auction_name, presence: true, length: { maximum: 200}
#  validates :bidor_price, numericality: { only_integer: true }, allow_blank: true
  validates :price, presence: true, numericality: { only_integer: true }
#  validates :quantity, presence: true,
#                       :numericality => { :only_integer => true,
#                                          :greater_than_or_equal_to => 0,
#                                          :less_than_or_equal_to => 9 }
#  validates :bids, presence: true,
#                   :numericality => { :only_integer => true,
#                                      :greater_than_or_equal_to => 0,
#                                      :less_than_or_equal_to => 999 }
  validates :seller_id, presence: true, length: { maximum: 50}
  validates :url, length: { maximum: 200}, allow_blank: true
  validates :sold_flg, presence: true,
                       :numericality => { :only_integer => true,
                                          :greater_than_or_equal_to => 0,
                                          :less_than_or_equal_to => 9 }
  validates :memo, length: { maximum: 200}, allow_blank: true
end
