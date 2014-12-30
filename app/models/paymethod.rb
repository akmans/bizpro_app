class Paymethod < ActiveRecord::Base
  self.primary_key = "paymethod_id"
  
  default_scope -> { order(paymethod_id: :ASC) }
  
  validates :paymethod_id, # presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :paymethod_name, presence: true, length: { maximum: 100}
  
  def as_hash
    {self.paymethod_id => self.paymethod_name}
  end

  before_create do
    self.paymethod_id = generate_paymethod_id if paymethod_id.blank?
  end
  
  private
    # generate paymethod id
    def generate_paymethod_id
      max_id = Paymethod.maximum(:paymethod_id)
      return "P001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + next_id.to_s.rjust(3, '0')
    end
end
