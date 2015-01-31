#encoding: utf-8
require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  def setup
    @shipment = Shipment.new(
      :shipment_id => 'Product_id',
      :shipmethod_id => 'S_id',
      :memo => 'メモメモ'
    )
  end

  # test @shipment
  test "should be valid" do
    assert @shipment.valid?
  end

  # test field shipment_id
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

  # test field shipmethod_id
  test "shipmethod_id should be presence" do
    @shipment.shipmethod_id = nil
    assert_not @shipment.valid?
  end

  test "shipmethod_id should not be too long" do
    @shipment.shipmethod_id = "a" * 5
    assert_not @shipment.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @shipment.memo = nil
    assert @shipment.valid?
  end

  test "memo should not be too long" do
    @shipment.memo = "a" * 201
    assert_not @shipment.valid?
  end

  # test ORDER BY
  test "order should be newest ID first" do
    assert_equal Shipment.first, shipments(:one)
  end

  # test before_create
  test "should auto generate shipment id when id not presence" do
    @shipment.save
    @shipment.reload
    assert_not_nil @shipment.shipment_id
  end
end
