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
    yahoojp_log_out_help if yahoojp_logged_in_help?
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help('一覧,オークション')
    assert_not_nil assigns(:auctions)
    assert_template 'auctions/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_auction_path, text: 'New'
    Auction.paginate(page: 1, per_page: 15).each do |auction|
      assert_select 'a[href=?]', auction_path(auction.auction_id), text: 'Dis'
      assert_select 'a[href=?]', edit_auction_path(auction.auction_id), text: 'Edi'
      assert_select 'a[href=?]', auction_path(auction.auction_id), text: 'Del', method: :delete
    end
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
    assert_select 'title', full_title_help('表示,オークション')
    assert_not_nil assigns(:auction)
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
    assert_select 'title', full_title_help('ロード,オークション')
    assert_nil assigns(:auction)
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test create action
  # nil

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, auction_id: @auction
    assert_response :success
    assert_select 'title', full_title_help('編集,オークション')
    assert_not_nil assigns(:auction)
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
          auction: {
            auction_name: auction_name,
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
    assert_equal '更新完了しました。', flash[:success]
  end

  test "should redirect update when not logged in" do
    auction_name = "てすと"
    price = 123
    sold_flg = 1
    memo = 'メモメモメモ'
    patch :update, auction_id: @auction,
          auction: {
            auction_name: auction_name,
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
    assert_equal '削除完了しました。', flash[:success]
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Auction.count' do
      delete :destroy, auction_id: @auction
    end
    assert_redirected_to login_url
  end

  # test loaddata action
  # nil

  # test callback action
  test "should do callback when logged in" do
    log_in_as(@user)
    request.env['omniauth.auth'] = @auth
    get :callback, :provider => 'yahoojp'
    assert_template 'auctions/new'
    assert_select 'a[href=?]', "/auth/yahoojp/logout", text: 'ログアウト'
    assert_select 'a[href=?]', "/auth/yahoojp/loaddata1", text: 'ロード買いデータ'
    assert_select 'a[href=?]', "/auth/yahoojp/loaddata2", text: 'ロード売りデータ'
    assert_select 'a[href=?]', auctions_path, text: '戻る'
  end

  test "should redirect callback when not logged in" do
    request.env['omniauth.auth'] = @auth
    get :callback, :provider => 'yahoojp'
    assert_redirected_to login_url
  end

  # test logout action
  test "should do logout when logged in" do
    log_in_as(@user)
    get :logout, :provider => 'yahoojp'
    assert_template 'auctions/new'
    assert_select 'a[href=?]', "/auth/yahoojp", text: 'Yahoo! JAPAN でlogin'
    assert_select 'a[href=?]', auctions_path, text: '戻る'
  end

  test "should redirect logout when not logged in" do
    get :logout, :provider => 'yahoojp'
    assert_redirected_to login_url
  end

  # test ajax_auctions action
  test "get ajax_auctions should get json data when logged in" do
    log_in_as(@user)
    expected = {""=>"(空白)", "One1"=>"OneOneOneOneOne 11111", \
        "Three3"=>"ThreeThreeThree 333", "Four4"=>"FourFourFourFour 4444", \
        "Five5"=>"FiveFiveFiveFiveFive 55555"}
    xhr :get, :ajax_auctions, ope_flg: 0
    assert_equal expected, JSON.parse(response.body)
  end

  test "get ajax_auctions should show message when not logged in" do
    xhr :get, :ajax_auctions, ope_flg: 0
    assert_equal 'Please log in.', flash[:danger]
  end
end