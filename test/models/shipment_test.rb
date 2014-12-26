#encoding: utf-8
require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  def setup
    @shipment = Shipment.new(:shipment_id => 'Product_id',
                           :shipmethod_id => 'S_id',
                           :memo => 'メモメモ'
                           )
  end
  
  test "should be valid" do
    assert @shipment.valid?
  end
  
  test "shipment_id should be allow blank" do
    @shipment.shipment_id = "     "
    assert @shipment.valid?
  end
  
  test "shipment_id should not be too long" do
    @shipment.shipment_id = "a" * 21
    assert_not @shipment.valid?
  end
  
  test "shipment_id should be unique" do
    duplicate_shipment = @shipment.dup
    duplicate_shipment.shipment_id = @shipment.shipment_id.upcase
    @shipment.save
    assert_not duplicate_shipment.valid?
  end
  
  test "shipmethod_id should be presence" do
    @shipment.shipmethod_id = nil
    assert_not @shipment.valid?
  end
  
  test "shipmethod_id should not be too long" do
    @shipment.shipmethod_id = "a" * 5
    assert_not @shipment.valid?
  end
  
  test "memo should allow blank" do
    @shipment.memo = nil
    assert @shipment.valid?
  end
  
  test "memo should not be too long" do
    @shipment.memo = "a" * 201
    assert_not @shipment.valid?
  end
end
