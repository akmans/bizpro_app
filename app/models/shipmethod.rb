class Shipmethod < ActiveRecord::Base
  self.primary_key = "shipmethod_id"
  
  default_scope -> { order(shipmethod_id: :ASC) }
  
  validates :shipmethod_id, presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :shipmethod_type, presence: true,
                              :numericality => { :only_integer => true,
                                                 :greater_than_or_equal_to => 0,
                                                 :less_than_or_equal_to => 1 }
  validates :shipmethod_name, presence: true, length: { maximum: 100}
  
  def as_hash
    {self.shipmethod_id => self.shipmethod_name}
  end
end
