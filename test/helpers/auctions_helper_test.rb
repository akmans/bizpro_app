#encoding: utf-8
require 'test_helper'

class AuctionsHelperTest < ActionView::TestCase

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
    @auction = auctions(:one)
  end

  def teardown
    OmniAuth.config.mock_auth[:yahoojp] = nil
    yahoojp_log_out_help
  end

  # test yahoojp_logged_in_help
  test "test yahoojp log in help" do
    yahoojp_log_in_help(OmniAuth.config.mock_auth[:yahoojp])
    assert_equal @auth.uid, session[:y_user_id]
    assert_equal @auth.credentials.token, session[:y_token]
    assert_equal @auth.credentials.refresh_token, session[:y_refresh_token]
    assert_equal @auth.credentials.expires_at, session[:y_expires_at]
    assert_equal @auth.info.name, session[:y_user_name]
    assert_equal @auth.info.email, session[:y_email]
  end

  # test yahoojp_logged_in_help?
  test "test yahoojp loged in help?" do
    assert_equal false, yahoojp_logged_in_help?
    yahoojp_log_in_help(OmniAuth.config.mock_auth[:yahoojp])
    assert_equal true, yahoojp_logged_in_help?
  end

  # test yahoojp_log_out_help
  test "test yahoojp log out help" do
    yahoojp_log_in_help(OmniAuth.config.mock_auth[:yahoojp])
    yahoojp_log_out_help
    assert_nil session[:y_user_id]
    assert_nil session[:y_token]
    assert_nil session[:y_refresh_token]
    assert_nil session[:y_expires_at]
    assert_nil session[:y_user_name]
    assert_nil session[:y_email]
  end

  # yahoojp_expires_at_help
  test "test yahoojp expires at help" do
    yahoojp_log_in_help(OmniAuth.config.mock_auth[:yahoojp])
    assert_not_nil yahoojp_expires_at_help
  end

  # test yahoojp_expired_help?
  test "test yahoojp expired help?" do
    session[:y_expires_at] = DateTime.now.to_i - 1
    assert_equal true, yahoojp_expired_help?
    session[:y_expires_at] = DateTime.now.to_i + 1
    assert_equal false, yahoojp_expired_help?
  end

  # test tax_rate_hash_help
  test "test tax rate hash help" do
    expected = {"0" => "０％", "5" => "５％", "8" => "８％", "10" => "１０％"}
    assert_equal expected, tax_rate_hash_help
  end

  # test tax_rate_name_help
  test "test tax rate name help" do
    assert_equal "０％", tax_rate_name_help(0)
    assert_equal "５％", tax_rate_name_help(5)
    assert_equal "８％", tax_rate_name_help(8)
    assert_equal "１０％", tax_rate_name_help(10)
  end

  # test ope_flg_hash_help
  test "test ope flg hash help" do
    expected = {"" => "(空白)", "0" => "カス品", "1" => "商品"}
    assert_equal expected, ope_flg_hash_help
  end

  # test ope_flg_name_help
  test "test ope flg name help" do
    assert_equal "-", ope_flg_name_help(nil)
    assert_equal "-", ope_flg_name_help("")
    assert_equal "カス品", ope_flg_name_help(0)
    assert_equal "商品", ope_flg_name_help(1)
  end

  # test custom_percentage_help
  test "test custom percentage help" do
    assert_equal nil, custom_percentage_help(nil)
    assert_equal nil, custom_percentage_help("Two2")
    assert_equal "(50)", custom_percentage_help("One1")
  end

  # test sold_type_hash_help
  test "test sold type hash help" do
    expected = {"0" => "買い品", "1" => "売り品"}
    assert_equal expected, sold_type_hash_help
  end

  # test sold_type_name_help
  test "test sold type name help" do
    assert_equal "買い品", sold_type_name_help(0)
    assert_equal "売り品", sold_type_name_help(1)
  end

  # test ship_type_hash_help
  test "test ship type hash help" do
    expected = {"0" => "元払い", "1" => "着払い"}
    assert_equal expected, ship_type_hash_help
  end

  # test ship_type_name_help
  test "test ship type name help" do
    assert_equal "元払い", ship_type_name_help(0)
    assert_equal "着払い", ship_type_name_help(1)
  end

  # test auction_total_cost_help
  test "test auction total cost help" do
    @auction.price = 100
    @auction.tax_rate = nil
    @auction.payment_cost = nil
    @auction.shipment_cost = nil
    assert_equal 100 * -1, auction_total_cost_help(@auction)
    @auction.tax_rate = 5
    assert_equal 105 * -1, auction_total_cost_help(@auction)
    @auction.payment_cost = 10
    assert_equal 115 * -1, auction_total_cost_help(@auction)
    @auction.shipment_cost = 1000
    @auction.ship_type = 1
    assert_equal 1115 * -1, auction_total_cost_help(@auction)
  end

  # test auction_name_help
  test "test auction name help" do
    assert_equal "OneOneOneOneOne 11111", auction_name_help(@auction.auction_id)
  end

  # test auctions_hash_help
  test "test auction hash help" do
    expected = {"" => "(空白)", "Three3" => "ThreeThreeThree 333"}
    assert_equal expected, auctions_hash_help(0)
  end
end