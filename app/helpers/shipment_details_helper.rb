module ShipmentDetailsHelper
  def shipment_detail_total_cost(key)
    0
  end

  def shipment_detail_count(key)
    ShipmentDetail.count(shipment_id: key)
  end

  def shipment_detail_product_name(key)
    (Product.find(key).product_name if Product.exists?(key)) || '-'
  end
end
