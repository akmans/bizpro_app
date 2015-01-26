module ShipmentsHelper
  def shipment_cost_help(shipment_id)
    shipment_details = ShipmentDetail.where(shipment_id: shipment_id)
    total_cost = 0
    shipment_details.each do |sd|
      total_cost += (sd.ship_cost || 0)
      total_cost += (sd.insured_cost || 0)
      rate = Product.find(sd.product_id).exchange_rate || 8.3
      total_cost += (sd.custom_cost || 0) * rate
    end
    return total_cost.to_i
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
