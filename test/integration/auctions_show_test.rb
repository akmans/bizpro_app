#encoding: utf-8
require 'test_helper'

class AuctionsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @auction = auctions(:one)
  end
  
  test "show including index links" do
    log_in_as(@user)
    get auction_path(@auction)
    assert_template 'auctions/show'
    assert_select 'a[href=?]', @auction.url, text: @auction.auction_id
    assert_select 'a[href=?]', auctions_path, text: '戻る'
  end
end
