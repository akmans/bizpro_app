#encoding: utf-8
require 'test_helper'

class AuctionsControllerTest < ActionController::TestCase
  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:yahoojp] = OmniAuth::AuthHash.new({
      :provider => 'yahoojp',
      :uid => 'UID',
      :credentials => {
        :token => "TOKEN",
        :refresh_token => "REFRESH_TOKEN",
        :expires_at => DateTime.now.to_i + 3600},
      :info => {
        :name => "NAME",
        :email => "EMAIL"}
    })
    @auth = OmniAuth.config.mock_auth[:yahoojp]
    @user = users(:one)
    @auction = auctions(:one)
  end

  def teardown
    OmniAuth.config.mock_auth[:yahoojp] = nil
    yahoojp_log_out if yahoojp_logged_in?
  end

  # test routes
  test "should route to index" do
    assert_routing "/auctions",
                   { controller: "auctions", action: "index" }
  end
 
  test "should route to show" do
    assert_routing "/auctions/#{@auction.auction_id}",
                   { controller: "auctions", action: "show", auction_id: "#{@auction.auction_id}" }
  end
 
  test "should route to new" do
    assert_routing "/auctions/new",
                   { controller: "auctions", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/auctions' },
                   { controller: "auctions", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/auctions/#{@auction.auction_id}/edit",
                   { controller: "auctions", action: "edit", auction_id: "#{@auction.auction_id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/auctions/#{@auction.auction_id}" },
                   { controller: "auctions", action: "update", auction_id: "#{@auction.auction_id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/auctions/#{@auction.auction_id}" },
                   { controller: "auctions", action: "destroy", auction_id: "#{@auction.auction_id}" })
  end
 
  test "should route to ajax_auctions" do
    assert_routing "/ajax/auctions",
                   { controller: "auctions", action: "ajax_auctions" }
  end
 
  test "should route to callback" do
    assert_routing "/auth/yahoojp/callback",
                   { controller: "auctions", action: "callback", provider: "yahoojp" }
  end
 
  test "should route to logout" do
    assert_routing "/auth/yahoojp/logout",
                   { controller: "auctions", action: "logout", provider: "yahoojp" }
  end
 
  test "should route to loaddata" do
    assert_routing "/auth/yahoojp/loaddata",
                   { controller: "auctions", action: "loaddata", provider: "yahoojp" }
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,オークション')
    assert_not_nil assigns(:auctions)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  # test show action
  test "should get show when logged in" do
    log_in_as(@user)
    get :show, auction_id: @auction
    assert_response :success
    assert_select 'title', full_title('表示,オークション')
    assert_not_nil assigns(:auction)
    assert_equal "First Name", assigns(:category_name)
    assert_equal "First Name", assigns(:brand_name)
    assert_equal "First Name", assigns(:modu_name)
    assert_equal "First Name", assigns(:shipmethod_name)
    assert_equal "First Name", assigns(:paymethod_name)
  end
  
  test "should redirect show when not logged in" do
    get :show, auction_id: @auction
    assert_redirected_to login_url
  end
  
  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
    assert_select 'title', full_title('ロード,オークション')
    assert_nil assigns(:auction)
  end
 
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, auction_id: @auction
    assert_response :success
    assert_select 'title', full_title('編集,オークション')
    assert_not_nil assigns(:auction)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:brands)
    assert_not_nil assigns(:modus)
    assert_not_nil assigns(:paymethods)
    assert_not_nil assigns(:shipmethods)
  end

  test "should redirect edit when not logged in" do
    get :edit, auction_id: @auction
    assert_not flash.empty?
    assert_redirected_to login_url
  end
 
  # test update action
  test "should update auction when logged in" do
    log_in_as(@user)
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    ope_flg = 1
    category_id = "Two2"
    brand_id = "Two2"
    modu_id = "TwoTwo2"
    shipmethod_id = "Two2"
    ship_type = 1
    paymethod_id = "Two2"
    memo = 'メモメモメモ'
    patch :update, auction_id: @auction.auction_id,
          auction: { auction_name: auction_name,
                     price: price,
                     sold_flg: sold_flg,
                     ope_flg: ope_flg,
                     category_id: category_id,
                     brand_id: brand_id,
                     modu_id: modu_id,
                     shipmethod_id: shipmethod_id,
                     ship_type: ship_type,
                     paymethod_id: paymethod_id,
                     memo: memo
          }
    @auction.reload
    assert_equal @auction.auction_name, auction_name
    assert_equal @auction.price.to_i, price
    assert_equal @auction.sold_flg, sold_flg
    assert_equal @auction.ope_flg, ope_flg
    assert_equal @auction.category_id, category_id
    assert_equal @auction.brand_id, brand_id
    assert_equal @auction.modu_id, modu_id
    assert_equal @auction.shipmethod_id, shipmethod_id
    assert_equal @auction.ship_type, ship_type
    assert_equal @auction.paymethod_id, paymethod_id
    assert_equal @auction.memo, memo
    assert_redirected_to auctions_path
  end

  test "should redirect update when not logged in" do
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    memo = 'メモメモメモ'
    patch :update, auction_id: @auction,
          auction: { auction_name: auction_name,
                     price: price,
                     sold_flg: sold_flg,
                     memo: memo
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test destory action
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