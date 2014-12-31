class Brand < ActiveRecord::Base
  has_many :modus, dependent: :destroy
  self.primary_key = "brand_id"

  default_scope -> { order(brand_id: :ASC) }

  validates :brand_id , # presence: true,
                        length: { maximum: 4},
                        uniqueness: {case_sensitive: false }
  validates :brand_name, presence: true, length: { maximum: 100}

  def as_hash
    {self.brand_id => self.brand_name}
  end

  before_create do
    self.brand_id = generate_brand_id if brand_id.blank?
  end

  private
    # generate brand id
    def generate_brand_id
      max_id = Brand.maximum(:brand_id)
      return "B001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + next_id.to_s.rjust(3, '0')
    end
end
