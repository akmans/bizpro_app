#encoding: utf-8
require 'test_helper'

class AuctionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @auction = auctions(:two)
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,オークション')
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
    assert_select 'title', full_title('ロード,オークション')
  end
 
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, auction_id: @auction
    assert_response :success
    assert_select 'title', full_title('編集,オークション')
  end

  test "should redirect edit when not logged in" do
    get :edit, auction_id: @auction
    assert_not flash.empty?
    assert_redirected_to login_url
  end
 
  # test action update
  test "should update auction when logged in" do
    log_in_as(@user)
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    memo = 'メモメモメモ'
    patch :update, auction_id: @auction, \
          auction: { auction_name: auction_name,
                     price: price,
                     sold_flg: sold_flg,
                     memo: memo
          }
    @auction.reload
    assert_equal @auction.auction_name, auction_name
    assert_equal @auction.price, price
    assert_equal @auction.sold_flg, sold_flg
    assert_equal @auction.memo, memo
    assert_redirected_to auctions_path
  end

  test "should redirect update when not logged in" do
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    memo = 'メモメモメモ'
    patch :update, auction_id: @auction, \
          auction: { auction_name: auction_name,
                     price: price,
                     sold_flg: sold_flg,
                     memo: memo
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy auction when logged in" do
    log_in_as(@user)
    assert_difference 'Auction.count', -1 do
      delete :destroy, auction_id: @auction
    end
    assert_redirected_to auctions_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Auction.count' do
      delete :destroy, auction_id: @auction
    end
    assert_redirected_to login_url
  end

end
