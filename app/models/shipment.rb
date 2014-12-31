class Shipment < ActiveRecord::Base
  has_many :shipment_details, dependent: :destroy
  self.primary_key = "shipment_id"

  default_scope -> { order(sent_date: :DESC) }
  validates :shipment_id , # presence: true,
                          length: { maximum: 20},
                          uniqueness: {case_sensitive: false }
  validates :shipmethod_id , presence: true, length: { maximum: 4}
  validates :memo, length: { maximum: 200}, allow_blank: true

  before_create do
    self.shipment_id = generate_shipment_id if shipment_id.blank?
  end

  private
    def generate_shipment_id
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      begin
        string = (0...10).map { o[rand(o.length)] }.join
      end until !Shipment.exists?(:shipment_id => string)
      string
    end
end
