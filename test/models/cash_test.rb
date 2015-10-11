require 'test_helper'

class CashTest < ActiveSupport::TestCase
  def setup
    @cash = Cash.new(
      :cash_id => 'Cash_id',
      :remark => 'Cash Name',
      :is_domestic => 1,
      :is_in => 1,
      :exchange_rate => 1.0,
      :memo => nil
    )
  end

  # test @cash
  test "should be valid" do
    assert @cash.valid?
  end

  # test field cash_id
  test "cash_id should be presence" do
    @cash.cash_id = "    "
    assert @cash.valid?
  end

  test "cash_id should not be too long" do
    @cash.cash_id = "a" * 21
    assert_not @cash.valid?
  end

  test "cash_id should be unique" do
    duplicate_cash = @cash.dup
    duplicate_cash.cash_id = @cash.cash_id.upcase
    @cash.save
    assert_not duplicate_cash.valid?
  end

  # test field remark
  test "remark should be presence" do
    @cash.remark = "    "
    assert_not @cash.valid?
  end

  test "remark should not be too long" do
    @cash.remark = "a" * 201
    assert_not @cash.valid?
  end

  test "is_domestic should be numericality" do
    @cash.is_domestic = "a"
    assert_not @cash.valid?
  end

  test "is_domestic should be integer" do
    @cash.is_domestic = 0.2
    assert_not @cash.valid?
  end

  test "is_domestic should be more than 0" do
    @cash.is_domestic = -1
    assert_not @cash.valid?
  end

  test "is_domestic should be less than 4" do
    @cash.is_domestic = 4
    assert_not @cash.valid?
  end

  # test field is_in
  test "is_in should be presence" do
    @cash.is_in = nil
    assert_not @cash.valid?
  end

  test "is_in should be numericality" do
    @cash.is_in = "a"
    assert_not @cash.valid?
  end

  test "is_in should be integer" do
    @cash.is_in = 1.2
    assert_not @cash.valid?
  end

  test "is_in should be more than 0" do
    @cash.is_in = -1
    assert_not @cash.valid?
  end

  test "is_in should be less than 10" do
    @cash.is_in = 10
    assert_not @cash.valid?
  end

  # test field exchange_rate
  test "exchange_rate should allow blank" do
    @cash.exchange_rate = nil
    assert @cash.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @cash.memo = nil
    assert @cash.valid?
  end

  test "memo should not be too long" do
    @cash.memo = "a" * 201
    assert_not @cash.valid?
  end
end
