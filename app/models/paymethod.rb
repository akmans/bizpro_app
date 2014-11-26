class Paymethod < ActiveRecord::Base
  self.primary_key = "paymethod_id"
  
  default_scope -> { order(paymethod_id: :ASC) }
  
  validates :paymethod_id, presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :paymethod_name, presence: true, length: { maximum: 100}
  
end
