class ShipmentDetail < ActiveRecord::Base
  belongs_to :shipment

  default_scope -> { order(product_id: :ASC) }

  validates :shipment_id, presence: true, length: { maximum: 20}
  validates :product_id, presence: true, length: { maximum: 20}

  validates :memo, length: { maximum: 200}, allow_blank: true
end
