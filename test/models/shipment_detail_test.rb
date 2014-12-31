require 'test_helper'

class ShipmentDetailTest < ActiveSupport::TestCase
  def setup
    @shipmentdetail = ShipmentDetail.new(
      :shipment_id => 'shipment_id',
      :product_id => 'product_id'
    )
  end

  test "should be valid" do
    assert @shipmentdetail.valid?
  end

  test "shipment_id should be presence" do
    @shipmentdetail.shipment_id = "    "
    assert_not @shipmentdetail.valid?
  end

  test "shipment_id should not be too long" do
    @shipmentdetail.shipment_id = "a" * 21
    assert_not @shipmentdetail.valid?
  end

  test "product_id should be presence" do
    @shipmentdetail.product_id = "    "
    assert_not @shipmentdetail.valid?
  end

  test "product_id should not be too long" do
    @shipmentdetail.product_id = "a" * 21
    assert_not @shipmentdetail.valid?
  end

  test "memo should allow blank" do
    @shipmentdetail.memo = nil
    assert @shipmentdetail.valid?
  end

  test "memo should not be too long" do
    @shipmentdetail.memo = "a" * 201
    assert_not @shipmentdetail.valid?
  end

  test "order should be the minimum product_id data first" do
    assert_equal ShipmentDetail.first, shipment_details(:one)
  end
end
