class Shipmethod < ActiveRecord::Base
  self.primary_key = "shipmethod_id"
  
  default_scope -> { order(shipmethod_id: :ASC) }
  
  validates :shipmethod_id, # presence: true,
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

  before_create do
    self.shipmethod_id = generate_shipmethod_id if shipmethod_id.blank?
  end
  
  private
    # generate shipmethod id
    def generate_shipmethod_id
      max_id = Shipmethod.maximum(:shipmethod_id)
      return "S001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + next_id.to_s.rjust(3, '0')
    end
end
