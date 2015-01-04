module ShipmentDetailsHelper
#  def shipment_detail_total_cost_help(id)
#    detail = ShipmentDetail.find(id)
#    ((detail.ship_cost || 0) + (detail.insured_cost || 0) + (detail.custom_cost || 0)).to_i
#  end

  def shipment_detail_cnt_help(shipment_id)
    ShipmentDetail.where(shipment_id: shipment_id).count
  end
end
