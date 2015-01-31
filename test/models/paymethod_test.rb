require 'test_helper'

class PaymethodTest < ActiveSupport::TestCase
  def setup
    @paymethod = Paymethod.new(:paymethod_name => 'Paymethod Name')
  end

  # test @paymethod
  test "should be valid" do
    assert @paymethod.valid?
  end

  # test field paymethod_id
  test "paymethod_id should be allow blank" do
    @paymethod.paymethod_id = "    "
    assert @paymethod.valid?
  end

  test "paymethod_id should not be too long" do
    @paymethod.paymethod_id = "a" * 5
    assert_not @paymethod.valid?
  end

  test "paymethod_id should be unique" do
    @paymethod.paymethod_id = "test"
    duplicate_paymethod = @paymethod.dup
    duplicate_paymethod.paymethod_id = @paymethod.paymethod_id.upcase
    @paymethod.save
    assert_not duplicate_paymethod.valid?
  end

  # test field paymethod_name
  test "paymethod_name should be presence" do
    @paymethod.paymethod_name = "    "
    assert_not @paymethod.valid?
  end

  test "paymethod_name should not be too long" do
    @paymethod.paymethod_name = "a" * 101
    assert_not @paymethod.valid?
  end

  # test ORDER BY
  test "order should be miximum ID first" do
    assert_equal Paymethod.first, paymethods(:one)
  end

  # test as_hash
  test "should get data as hash" do
    @paymethod.paymethod_id = 'TEST'
    expected = {'TEST' => 'Paymethod Name'}
    assert_equal expected, @paymethod.as_hash
  end

  # test before_create
  test "should auto generate paymethod id when id not presence" do
    @paymethod.save
    @paymethod.reload
    assert_not_nil @paymethod.paymethod_id
  end
end
