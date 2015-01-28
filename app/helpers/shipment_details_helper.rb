module ShipmentDetailsHelper
  # return shipment detail count
  def shipment_detail_cnt_help(shipment_id)
    ShipmentDetail.where(shipment_id: shipment_id).count
  end

  # return shipment count by product_id
  def shipment_detail_cnt_by_product_id(product_id)
    ShipmentDetail.where(product_id: product_id).count
  end

  # return shipmethod name by shipment_id
  def shipment_product_cost_help(shipment_detail)
    total_cost = 0
    total_cost += (shipment_detail.ship_cost || 0)
    total_cost += (shipment_detail.insured_cost || 0)
    rate = Product.find(shipment_detail.product_id).exchange_rate || 8.3
    total_cost += (shipment_detail.custom_cost || 0) * rate
    return total_cost
  end
end
