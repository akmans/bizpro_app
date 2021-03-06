require 'test_helper'

class CustomTest < ActiveSupport::TestCase
  def setup
    @custom = Custom.new(
      # :custom_id => 'Custom_id',
      :custom_name => 'Custom Name',
      :is_auction => 1,
      :auction_id => 'Auction Id',
      :net_cost => 0,
      :tax_cost => 0,
      :other_cost => 0
    )
  end

  # test @custom
  test "should be valid" do
    assert @custom.valid?
  end

  # test field custom_id
  test "custom_id should be presence" do
    @custom.custom_id = "    "
    assert @custom.valid?
  end

  test "custom_id should not be too long" do
    @custom.custom_id = "a" * 21
    assert_not @custom.valid?
  end

  test "custom_id should be unique" do
    @custom.custom_id = "test"
    duplicate_custom = @custom.dup
    duplicate_custom.custom_id = @custom.custom_id.upcase
    @custom.save
    assert_not duplicate_custom.valid?
  end

  # test field custom_name
  test "custom_name should be presence" do
    @custom.custom_name = "    "
    assert_not @custom.valid?
  end

  test "custom_name should not be too long" do
    @custom.custom_name = "a" * 201
    assert_not @custom.valid?
  end

  # test field is_auction
  test "is_auction should be presence" do
    @custom.is_auction = nil
    assert_not @custom.valid?
  end

  test "is_auction should be numericality" do
    @custom.is_auction = "a"
    assert_not @custom.valid?
  end

  test "is_auction should be integer" do
    @custom.is_auction = 0.2
    assert_not @custom.valid?
  end

  test "is_auction should be more than 0" do
    @custom.is_auction = -1
    assert_not @custom.valid?
  end

  test "is_auction should be less than 2" do
    @custom.is_auction = 2
    assert_not @custom.valid?
  end

  # test field auction_id
  test "auction_id should be allow blank" do
    @custom.auction_id = "    "
    assert @custom.valid?
  end

  test "auction_id should not be too long" do
    @custom.auction_id = "a" * 21
    assert_not @custom.valid?
  end

  # test field net_cost
  test "net_cost should be allow blank" do
    @custom.net_cost = nil
    assert @custom.valid?
  end

  test "net_cost should be numericality" do
    @custom.net_cost = "a"
    assert_not @custom.valid?
  end

  test "net_cost should be integer" do
    @custom.net_cost = 1.2
    assert_not @custom.valid?
  end

  # test field tax_cost
  test "tax_cost should be integer" do
    @custom.tax_cost = 1.2
    assert_not @custom.valid?
  end

  test "tax_cost should be presence" do
    @custom.tax_cost = nil
    assert @custom.valid?
  end

  test "tax_cost should be numericality" do
    @custom.tax_cost = "a"
    assert_not @custom.valid?
  end

  # test field other_cost
  test "other_cost should be presence" do
    @custom.other_cost = nil
    assert @custom.valid?
  end

  test "other_cost should be numericality" do
    @custom.other_cost = "a"
    assert_not @custom.valid?
  end

  test "other_cost should be integer" do
    @custom.other_cost = 1.2
    assert_not @custom.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @custom.memo = nil
    assert @custom.valid?
  end

  test "memo should not be too long" do
    @custom.memo = "a" * 201
    assert_not @custom.valid?
  end

  # test field cancel_flg
  test "cancel_flg should allow blank" do
    @custom.cancel_flg = nil
    assert @custom.valid?
  end

  test "cancel_flg should be numericality" do
    @custom.cancel_flg = "a"
    assert_not @custom.valid?
  end

  test "cancel_flg should be integer" do
    @custom.cancel_flg = 0.2
    assert_not @custom.valid?
  end

  test "cancel_flg should be more than 0" do
    @custom.cancel_flg = -1
    assert_not @custom.valid?
  end

  test "cancel_flg should be less than 2" do
    @custom.cancel_flg = 2
    assert_not @custom.valid?
  end

  # test ORDER BY
  test "order should be newest regist_date first" do
    assert_equal Custom.first, customs(:two)
  end

  # test before_create
  test "should auto generate custom id when id not presence" do
    @custom.save
    @custom.reload
    assert_not_nil @custom.custom_id
  end
end
