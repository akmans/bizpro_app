module ShipmentsHelper
  # return shipment cost
  def shipment_cost_help(shipment_id)
    total_cost = 0
    return total_cost if shipment_id.nil?
    shipment_details = ShipmentDetail.where(shipment_id: shipment_id).all
    shipment_details.each do |sd|
      total_cost += (sd.ship_cost || 0)
      total_cost += (sd.insured_cost || 0)
      rate = Product.find(sd.product_id).exchange_rate || 8.3
      total_cost += (sd.custom_cost || 0) * rate
    end
    return -1 * total_cost.to_i
  end
end
