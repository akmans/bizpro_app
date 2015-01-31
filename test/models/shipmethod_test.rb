require 'test_helper'

class ShipmethodTest < ActiveSupport::TestCase
  def setup
    @shipmethod = Shipmethod.new(
      # :shipmethod_id => 'p001',
      :shipmethod_type => 0,
      :shipmethod_name => 'Shipmethod Name'
    )
  end

  # test @shipmethod
  test "should be valid" do
    assert @shipmethod.valid?
  end

  # test field shipmethod_id
  test "shipmethod_id should be allow blank" do
    @shipmethod.shipmethod_id = "    "
    assert @shipmethod.valid?
  end

  test "shipmethod_id should not be too long" do
    @shipmethod.shipmethod_id = "a" * 5
    assert_not @shipmethod.valid?
  end

  test "shipmethod_id should be unique" do
    @shipmethod.shipmethod_id = "test"
    duplicate_shipmethod = @shipmethod.dup
    duplicate_shipmethod.shipmethod_id = @shipmethod.shipmethod_id.upcase
    @shipmethod.save
    assert_not duplicate_shipmethod.valid?
  end

  # test field shipmethod_type
  test "shipmethod_type should be presence" do
    @shipmethod.shipmethod_type = nil
    assert_not @shipmethod.valid?
  end

  test "shipmethod_type should be numericality" do
    @shipmethod.shipmethod_type = "a"
    assert_not @shipmethod.valid?
  end

  test "shipmethod_type should be integer" do
    @shipmethod.shipmethod_type = 1.2
    assert_not @shipmethod.valid?
  end

  test "shipmethod_type should be more than 0" do
    @shipmethod.shipmethod_type = -1
    assert_not @shipmethod.valid?
  end

  test "shipmethod_type should be less than 2" do
    @shipmethod.shipmethod_type = 2
    assert_not @shipmethod.valid?
  end

  # test field shipmethod_name
  test "shipmethod_name should be presence" do
    @shipmethod.shipmethod_name = "    "
    assert_not @shipmethod.valid?
  end

  test "shipmethod_name should not be too long" do
    @shipmethod.shipmethod_name = "a" * 101
    assert_not @shipmethod.valid?
  end

  # test ORDER BY
  test "order should be miximum ID first" do
    assert_equal Shipmethod.first, shipmethods(:one)
  end

  # test as_hash
  test "should get data as hash" do
    @shipmethod.shipmethod_id = 'TEST'
    expected = {'TEST' => 'Shipmethod Name'}
    assert_equal expected, @shipmethod.as_hash
  end

  # test before_create
  test "should auto generate shipmethod id when id not presence" do
    @shipmethod.save
    @shipmethod.reload
    assert_not_nil @shipmethod.shipmethod_id
  end
end
