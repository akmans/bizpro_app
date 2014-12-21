#encoding: utf-8
require 'test_helper'

class AuctionsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @auction = auctions(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_auction_path(@auction)
    assert_template 'auctions/edit'
    patch auction_path(@auction), auction: { #auction_id:  "",
        auction_name: nil,
        price: 123,
        sold_flg: 1,
        memo: 'メモメモメモ'}
    assert_template 'auctions/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_auction_path(@auction)
    assert_template 'auctions/edit'
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    memo = 'メモメモメモ'
    patch auction_path(@auction), auction: { #auction_id:  "",
        auction_name: auction_name,
        price: price,
        sold_flg: sold_flg,
        memo: memo}
    assert_not flash.empty?
    assert_redirected_to auctions_path
    @auction.reload
    assert_equal @auction.auction_name, auction_name
    assert_equal @auction.price, price
    assert_equal @auction.sold_flg, sold_flg
    assert_equal @auction.memo, memo
  end
end
