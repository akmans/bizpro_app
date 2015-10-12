class Cash < ActiveRecord::Base
  self.primary_key = "cash_id"

  default_scope -> { order('case when regist_date is null then 1 else 0 end, regist_date desc') }

  validates :cash_id , # presence: true,
                         length: { maximum: 20},
                         uniqueness: {case_sensitive: false }
  validates :remark, presence: true, length: { maximum: 200}
  validates :is_domestic, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 3 }
  validates :is_in, presence: true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 1 }
  validates :memo, length: { maximum: 200}, allow_blank: true

  before_create do
    self.cash_id = generate_cash_id if cash_id.blank?
  end

  private
    def generate_cash_id
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      begin
        string = (0...13).map { o[rand(o.length)] }.join
      end until !Cash.exists?(:cash_id => string)
      string
    end
end
