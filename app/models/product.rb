class Product < ActiveRecord::Base
  self.primary_key = "product_id"

  default_scope -> { order('case when sold_date is null then 1 else 0 end, sold_date desc') }

  validates :product_id , # presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :product_name, presence: true, length: { maximum: 200}
  validates :is_domestic, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 2 }
  validates :category_id , length: { maximum: 4}
  validates :brand_id , length: { maximum: 4}
  validates :modu_id , length: { maximum: 7}
  validates :memo, length: { maximum: 200}, allow_blank: true

  def as_hash
    {self.product_id => self.product_name}
  end

  before_create do
    self.product_id = generate_product_id if product_id.blank?
  end

  private
    def generate_product_id
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      begin
        string = (0...13).map { o[rand(o.length)] }.join
      end until !Product.exists?(:product_id => string)
      string
    end
end
