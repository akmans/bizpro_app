require 'test_helper'

class PaymethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @paymethod = Paymethod.new(:paymethod_id => 'p001', :paymethod_name => 'Paymethod Name')
  end
  
  test "should be valid" do
    assert @paymethod.valid?
  end
  
  test "paymethod_id should be presence" do
    @paymethod.paymethod_id = "    "
    assert_not @paymethod.valid?
  end
  
  test "paymethod_id should not be too long" do
    @paymethod.paymethod_id = "a" * 5
    assert_not @paymethod.valid?
  end
  
  test "paymethod_id should be unique" do
    duplicate_paymethod = @paymethod.dup
    duplicate_paymethod.paymethod_id = @paymethod.paymethod_id.upcase
    @paymethod.save
    assert_not duplicate_paymethod.valid?
  end
  
  test "paymethod_name should be presence" do
    @paymethod.paymethod_name = "    "
    assert_not @paymethod.valid?
  end
  
  test "paymethod_name should not be too long" do
    @paymethod.paymethod_name = "a" * 101
    assert_not @paymethod.valid?
  end
end
