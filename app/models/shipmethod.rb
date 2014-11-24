class Shipmethod < ActiveRecord::Base
  self.primary_key = "shipmethod_id"
  
  default_scope -> { order('shipmethod_id ASC') }
  
  validates :shipmethod_id, presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :shipmethod_name, presence: true, length: { maximum: 100}
  
end
