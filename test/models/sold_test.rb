require 'test_helper'

class SoldTest < ActiveSupport::TestCase
  def setup
    @sold = Sold.new(
      :product_id => 'Product_id',
      :sold_date => Date.today,
      :sold_price => 100
    )
  end

  # test @sold
  test "should be valid" do
    assert @sold.valid?
  end

  # test field product_id
  test "product_id should be presence" do
    @sold.product_id = "    "
    assert_not @sold.valid?
  end

  test "product_id should not be too long" do
    @sold.product_id = "a" * 21
    assert_not @sold.valid?
  end

  # test field sold_date
  test "sold_date should be presence" do
    @sold.sold_date = nil
    assert_not @sold.valid?
  end

  # test field sold_price
  test "sold_price should be presence" do
    @sold.sold_price = " "
    assert_not @sold.valid?
  end

  test "sold_price should be numericality" do
    @sold.sold_price = "a"
    assert_not @sold.valid?
    @sold.sold_price = 1.1
    assert @sold.valid?
  end

  # test field ship_charge
  test "ship_charge should be allow blank" do
    @sold.ship_charge = nil
    assert @sold.valid?
  end

  test "ship_charge should be numericality" do
    @sold.ship_charge = "a"
    assert_not @sold.valid?
    @sold.ship_charge = 1.2
    assert @sold.valid?
  end

  # test field other_charge
  test "other_charge should be allow blank" do
    @sold.other_charge = nil
    assert @sold.valid?
  end

  test "other_charge should be numericality" do
    @sold.other_charge = "a"
    assert_not @sold.valid?
    @sold.other_charge = 1.3
    assert @sold.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @sold.memo = nil
    assert @sold.valid?
  end

  test "memo should not be too long" do
    @sold.memo = "a" * 201
    assert_not @sold.valid?
  end

  # test ORDER BY
  test "order should be newest sold data first" do
    assert_equal Sold.first, solds(:one)
  end
end
