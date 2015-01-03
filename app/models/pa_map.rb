class PaMap < ActiveRecord::Base
  self.primary_key = "auction_id"

  default_scope -> { order(created_at: :DESC) }

  validates :auction_id , presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :product_id , presence: true,
                          length: { maximum: 20}
end
