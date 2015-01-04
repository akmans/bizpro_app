class PcMap < ActiveRecord::Base
  self.primary_key = "custom_id"

  default_scope -> { order(created_at: :DESC) }

  validates :custom_id , presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :product_id , presence: true,
                          length: { maximum: 20}
end
