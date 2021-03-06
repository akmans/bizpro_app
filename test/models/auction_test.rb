require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  def setup
    @auction = Auction.new(
      :auction_id => 'Auction_id',
      :auction_name => 'Auction Name',
      :price => 1,
      :seller_id => 'Seller Id',
      :sold_flg => 0,
      :ope_flg => 0,
      :ship_type => 0
    )
  end

  # test @auction
  test "should be valid" do
    assert @auction.valid?
  end

  # test field auction_id
  test "auction_id should be presence" do
    @auction.auction_id = "    "
    assert_not @auction.valid?
  end

  test "auction_id should not be too long" do
    @auction.auction_id = "a" * 21
    assert_not @auction.valid?
  end

  test "auction_id should be unique" do
    duplicate_auction = @auction.dup
    duplicate_auction.auction_id = @auction.auction_id.upcase
    @auction.save
    assert_not duplicate_auction.valid?
  end

  # test field auction_name
  test "auction_name should be presence" do
    @auction.auction_name = "    "
    assert_not @auction.valid?
  end

  test "auction_name should not be too long" do
    @auction.auction_name = "a" * 201
    assert_not @auction.valid?
  end

  # test field price
  test "price should be presence" do
    @auction.price = nil
    assert_not @auction.valid?
  end

  test "price should be numericality" do
    @auction.price = "a"
    assert_not @auction.valid?
  end

  test "price should be integer" do
    @auction.price = 1.2
    assert_not @auction.valid?
  end

  # test field seller_id
  test "seller_id should be presence" do
    @auction.seller_id = "    "
    assert_not @auction.valid?
  end

  test "seller_id should not be too long" do
    @auction.seller_id = "a" * 51
    assert_not @auction.valid?
  end

  # test field url
  test "url should allow blank" do
    @auction.url = nil
    assert @auction.valid?
  end

  test "url should not be too long" do
    @auction.url = "a" * 201
    assert_not @auction.valid?
  end

  # test field sold_flg
  test "sold_flg should be presence" do
    @auction.sold_flg = nil
    assert_not @auction.valid?
  end

  test "sold_flg should be numericality" do
    @auction.sold_flg = "a"
    assert_not @auction.valid?
  end

  test "sold_flg should be integer" do
    @auction.sold_flg = 1.2
    assert_not @auction.valid?
  end

  test "sold_flg should be more than 0" do
    @auction.sold_flg = -1
    assert_not @auction.valid?
  end

  test "sold_flg should be less than 10" do
    @auction.sold_flg = 10
    assert_not @auction.valid?
  end

  # test field ope_flg
  test "ope_flg should be presence" do
    @auction.ope_flg = nil
    assert @auction.valid?
  end

  test "ope_flg should be numericality" do
    @auction.ope_flg = "a"
    assert_not @auction.valid?
  end

  test "ope_flg should be integer" do
    @auction.ope_flg = 0.2
    assert_not @auction.valid?
  end

  test "ope_flg should be more than 0" do
    @auction.ope_flg = -1
    assert_not @auction.valid?
  end

  test "ope_flg should be less than 3" do
    @auction.ope_flg = 3
    assert_not @auction.valid?
  end

  # test field category_id
  test "category_id should allow blank" do
    @auction.category_id = nil
    assert @auction.valid?
  end

  test "category_id should not be too long" do
    @auction.category_id = "a" * 5
    assert_not @auction.valid?
  end

  # test field brand_id
  test "brand_id should allow blank" do
    @auction.brand_id = nil
    assert @auction.valid?
  end

  test "brand_id should not be too long" do
    @auction.brand_id = "a" * 5
    assert_not @auction.valid?
  end

  # test field modu_id
  test "modu_id should allow blank" do
    @auction.modu_id = nil
    assert @auction.valid?
  end

  test "modu_id should not be too long" do
    @auction.modu_id = "a" * 8
    assert_not @auction.valid?
  end

  # test field paymethod_id
  test "paymethod_id should allow blank" do
    @auction.paymethod_id = nil
    assert @auction.valid?
  end

  test "paymethod_id should not be too long" do
    @auction.paymethod_id = "a" * 5
    assert_not @auction.valid?
  end

  # test field payment_cost
  test "payment_cost should be allow blank" do
    @auction.payment_cost = nil
    assert @auction.valid?
  end

  test "payment_cost should be numericality" do
    @auction.payment_cost = "a"
    assert_not @auction.valid?
  end

  test "payment_cost should be integer" do
    @auction.payment_cost = 1.2
    assert_not @auction.valid?
  end

  # test field ship_type
  test "ship_type should be allow blank" do
    @auction.ship_type = nil
    assert_not @auction.valid?
  end

  test "ship_type should be numericality" do
    @auction.ship_type = "a"
    assert_not @auction.valid?
  end

  test "ship_type should be integer" do
    @auction.ship_type = 0.2
    assert_not @auction.valid?
  end

  test "ship_type should be more than 0" do
    @auction.ship_type = -1
    assert_not @auction.valid?
  end

  test "ship_type should be less than 2" do
    @auction.ship_type = 2
    assert_not @auction.valid?
  end

  # test field shipmethod_id
  test "shipmethod_id should allow blank" do
    @auction.shipmethod_id = nil
    assert @auction.valid?
  end

  test "shipmethod_id should not be too long" do
    @auction.shipmethod_id = "a" * 5
    assert_not @auction.valid?
  end

  # test field shipment_cost
  test "shipment_cost should be presence" do
    @auction.shipment_cost = nil
    assert @auction.valid?
  end

  test "shipment_cost should be numericality" do
    @auction.shipment_cost = "a"
    assert_not @auction.valid?
  end

  test "shipment_cost should be integer" do
    @auction.shipment_cost = 1.2
    assert_not @auction.valid?
  end

  test "shipment_code should allow blank" do
    @auction.shipment_code = nil
    assert @auction.valid?
  end

  test "shipment_code should not be too long" do
    @auction.shipment_code = "a" * 13
    assert_not @auction.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @auction.memo = nil
    assert @auction.valid?
  end

  test "memo should not be too long" do
    @auction.memo = "a" * 201
    assert_not @auction.valid?
  end

  # test ORDER BY
  test "order should be the newest end_time data first" do
    assert_equal Auction.first, auctions(:one)
  end
end
