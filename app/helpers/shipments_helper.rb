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
end
