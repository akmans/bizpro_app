require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  def setup
    @auction = Auction.new(:auction_id => 'Auction_id',
                           :auction_name => 'Auction Name',
                           :price => 1,
                           :seller_id => 'Seller Id',
                           :sold_flg => 0,
                           :is_custom => 0,
                           :ship_type => 0
                           )
  end
  
  test "should be valid" do
    assert @auction.valid?
  end
  
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
  
  test "auction_name should be presence" do
    @auction.auction_name = "    "
    assert_not @auction.valid?
  end
  
  test "auction_name should not be too long" do
    @auction.auction_name = "a" * 201
    assert_not @auction.valid?
  end

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
  
  test "seller_id should be presence" do
    @auction.seller_id = "    "
    assert_not @auction.valid?
  end
  
  test "seller_id should not be too long" do
    @auction.seller_id = "a" * 51
    assert_not @auction.valid?
  end
  
  test "url should allow blank" do
    @auction.url = nil
    assert @auction.valid?
  end
  
  test "url should not be too long" do
    @auction.url = "a" * 201
    assert_not @auction.valid?
  end
  
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
  
  test "is_custom should be presence" do
    @auction.is_custom = nil
    assert_not @auction.valid?
  end
  
  test "is_custom should be numericality" do
    @auction.is_custom = "a"
    assert_not @auction.valid?
  end
  
  test "is_custom should be integer" do
    @auction.is_custom = 0.2
    assert_not @auction.valid?
  end
  
  test "is_custom should be more than 0" do
    @auction.is_custom = -1
    assert_not @auction.valid?
  end
  
  test "is_custom should be less than 2" do
    @auction.is_custom = 2
    assert_not @auction.valid?
  end
  
  test "category_id should allow blank" do
    @auction.category_id = nil
    assert @auction.valid?
  end
  
  test "category_id should not be too long" do
    @auction.category_id = "a" * 5
    assert_not @auction.valid?
  end
  
  test "brand_id should allow blank" do
    @auction.brand_id = nil
    assert @auction.valid?
  end
  
  test "brand_id should not be too long" do
    @auction.brand_id = "a" * 5
    assert_not @auction.valid?
  end
  
  test "modu_id should allow blank" do
    @auction.modu_id = nil
    assert @auction.valid?
  end
  
  test "modu_id should not be too long" do
    @auction.modu_id = "a" * 8
    assert_not @auction.valid?
  end
  
  test "paymethod_id should allow blank" do
    @auction.paymethod_id = nil
    assert @auction.valid?
  end
  
  test "paymethod_id should not be too long" do
    @auction.paymethod_id = "a" * 5
    assert_not @auction.valid?
  end

  test "payment_cost should be presence" do
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
  
  test "ship_type should be presence" do
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
  
  test "shipmethod_id should allow blank" do
    @auction.shipmethod_id = nil
    assert @auction.valid?
  end
  
  test "shipmethod_id should not be too long" do
    @auction.shipmethod_id = "a" * 5
    assert_not @auction.valid?
  end

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
  
  test "memo should allow blank" do
    @auction.memo = nil
    assert @auction.valid?
  end
  
  test "memo should not be too long" do
    @auction.memo = "a" * 201
    assert_not @auction.valid?
  end
end
