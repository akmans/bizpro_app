require 'test_helper'

class ShipmethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @shipmethod = Shipmethod.new(:shipmethod_id => 'p001',
                                 :shipmethod_type => 0,
                                 :shipmethod_name => 'Shipmethod Name')
  end
  
  test "should be valid" do
    assert @shipmethod.valid?
  end
  
  test "shipmethod_id should be presence" do
    @shipmethod.shipmethod_id = "    "
    assert_not @shipmethod.valid?
  end
  
  test "shipmethod_id should not be too long" do
    @shipmethod.shipmethod_id = "a" * 5
    assert_not @shipmethod.valid?
  end
  
  test "shipmethod_id should be unique" do
    duplicate_shipmethod = @shipmethod.dup
    duplicate_shipmethod.shipmethod_id = @shipmethod.shipmethod_id.upcase
    @shipmethod.save
    assert_not duplicate_shipmethod.valid?
  end
  
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
  
  test "shipmethod_name should be presence" do
    @shipmethod.shipmethod_name = "    "
    assert_not @shipmethod.valid?
  end
  
  test "shipmethod_name should not be too long" do
    @shipmethod.shipmethod_name = "a" * 101
    assert_not @shipmethod.valid?
  end
end
