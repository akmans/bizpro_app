class Custom < ActiveRecord::Base
  self.primary_key = "custom_id"

  default_scope -> { order(created_at: :DESC) }

  validates :custom_id , # presence: true,
                         length: { maximum: 20},
                         uniqueness: {case_sensitive: false }
  validates :custom_name, presence: true, length: { maximum: 200}
  validates :is_auction, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 1 }
  validates :auction_id , length: { maximum: 20}
  validates :net_cost, numericality: { only_integer: true }, allow_blank: true
  validates :tax_cost, numericality: { only_integer: true }, allow_blank: true
  validates :other_cost, numericality: { only_integer: true }, allow_blank: true
  validates :memo, length: { maximum: 200}, allow_blank: true

  before_create do
    self.custom_id = generate_custom_id if custom_id.blank?
  end

  private
    def generate_custom_id
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      begin
        string = (0...12).map { o[rand(o.length)] }.join
      end until !Custom.exists?(:custom_id => string)
      string
    end
end
