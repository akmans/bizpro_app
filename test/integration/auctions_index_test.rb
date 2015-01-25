#encoding: utf-8
require 'test_helper'

class AuctionsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @auction = auctions(:one)
  end
  
  test "index including pagination and new/show/edit/delete links" do
    log_in_as(@user)
    get auctions_path
    assert_template 'auctions/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_auction_path, text: '新規'
    Auction.paginate(page: 1, per_page: 15).each do |auction|
      assert_select 'a[href=?]', auction_path(auction.auction_id), text: '表示'
      assert_select 'a[href=?]', edit_auction_path(auction.auction_id), text: '編集'
      assert_select 'a[href=?]', auction_path(auction.auction_id), text: 'ー', method: :delete
    end
    assert_difference 'Auction.count', -1 do
      delete auction_path(@auction)
    end
  end
end
