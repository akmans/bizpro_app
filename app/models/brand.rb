class Brand < ActiveRecord::Base
  has_many :modus, dependent: :destroy
  self.primary_key = "brand_id"
  
  default_scope -> { order(brand_id: :ASC) }
  
  validates :brand_id , presence: true,
                        length: { maximum: 4},
                        uniqueness: {case_sensitive: false }
  validates :brand_name, presence: true, length: { maximum: 100}
  
end
