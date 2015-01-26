module ShipmentDetailsHelper
  # return shipment detail count
  def shipment_detail_cnt_help(shipment_id)
    ShipmentDetail.where(shipment_id: shipment_id).count
  end

  # return shipment count by product_id
  def shipment_detail_cnt_by_product_id(product_id)
    ShipmentDetail.where(product_id: product_id).count
  end
end
