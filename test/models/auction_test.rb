require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  def setup
    @auction = Auction.new(:auction_id => 'Auction_id',
                           :auction_name => 'Auction Name',
                           :price => 1,
                           :quantity => 1,
                           :bids => 0,
                           :seller_id => 'Seller Id',
                           :sold_flg => 0
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
  
  test "bidor_price should allow blank" do
    @auction.bidor_price = nil
    assert @auction.valid?
  end
  
  test "bidor_price should be numericality" do
    @auction.bidor_price = "a"
    assert_not @auction.valid?
  end
  
  test "bidor_price should be integer" do
    @auction.bidor_price = 1.2
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
  
  test "quantity should be presence" do
    @auction.quantity = nil
    assert_not @auction.valid?
  end
  
  test "quantity should be numericality" do
    @auction.quantity = "a"
    assert_not @auction.valid?
  end
  
  test "quantity should be integer" do
    @auction.quantity = 1.2
    assert_not @auction.valid?
  end
  
  test "quantity should be more than 0" do
    @auction.quantity = -1
    assert_not @auction.valid?
  end
  
  test "quantity should be less than 10" do
    @auction.quantity = 10
    assert_not @auction.valid?
  end
  
  test "bids should be presence" do
    @auction.bids = nil
    assert_not @auction.valid?
  end
  
  test "bids should be numericality" do
    @auction.bids = "a"
    assert_not @auction.valid?
  end
  
  test "bids should be integer" do
    @auction.bids = 1.2
    assert_not @auction.valid?
  end
  
  test "bids should be more than 0" do
    @auction.bids = -1
    assert_not @auction.valid?
  end
  
  test "bids should be less than 1000" do
    @auction.bids = 1000
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
  
  test "memo should allow blank" do
    @auction.memo = nil
    assert @auction.valid?
  end
  
  test "memo should not be too long" do
    @auction.memo = "a" * 201
    assert_not @auction.valid?
  end
end
