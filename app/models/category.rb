class Category < ActiveRecord::Base
  self.primary_key = "category_id"
  
  validates :category_id , presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :category_name, presence: true, length: { maximum: 100}
  
end
