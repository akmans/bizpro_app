class Category < ActiveRecord::Base
  self.primary_key = "category_id"

  default_scope -> { order(category_id: :ASC) }

  validates :category_id , # presence: true,
                           length: { maximum: 4},
                           uniqueness: {case_sensitive: false }
  validates :category_name, presence: true, length: { maximum: 100}

  def as_hash
    {self.category_id => self.category_name}
  end

  before_create do
    self.category_id = generate_category_id if category_id.blank?
  end

  private
    # generate category id
    def generate_category_id
      max_id = Category.maximum(:category_id)
      return "C001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + next_id.to_s.rjust(3, '0')
    end
end
