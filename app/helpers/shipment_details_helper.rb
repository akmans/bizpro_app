module ShipmentDetailsHelper
  # return shipment detail count
  def shipment_detail_cnt_help(shipment_id)
    ShipmentDetail.where(shipment_id: shipment_id).count
  end
end
