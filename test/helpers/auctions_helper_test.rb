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
    yahoojp_log_out
  end

  test "test yahoojp log in" do
    yahoojp_log_in(OmniAuth.config.mock_auth[:yahoojp])
    assert_equal @auth.uid, session[:y_user_id]
    assert_equal @auth.credentials.token, session[:y_token]
    assert_equal @auth.credentials.refresh_token, session[:y_refresh_token]
    assert_equal @auth.credentials.expires_at, session[:y_expires_at]
    assert_equal @auth.info.name, session[:y_user_name]
    assert_equal @auth.info.email, session[:y_email]
  end

  test "test yahoojp loged in?" do
    assert_equal false, yahoojp_logged_in?
    yahoojp_log_in(OmniAuth.config.mock_auth[:yahoojp])
    assert_equal true, yahoojp_logged_in?
  end

  test "test yahoojp log out" do
    yahoojp_log_in(OmniAuth.config.mock_auth[:yahoojp])
    yahoojp_log_out
    assert_nil session[:y_user_id]
    assert_nil session[:y_token]
    assert_nil session[:y_refresh_token]
    assert_nil session[:y_expires_at]
    assert_nil session[:y_user_name]
    assert_nil session[:y_email]
  end

  test "test yahoojp expires at" do
    yahoojp_log_in(OmniAuth.config.mock_auth[:yahoojp])
    assert_not_nil yahoojp_expires_at
  end

  test "test yahoojp will expire?" do
    session[:y_expires_at] = DateTime.now.to_i + 61
    assert_equal false, yahoojp_will_expire?
    session[:y_expires_at] = DateTime.now.to_i + 59
    assert_equal true, yahoojp_will_expire?
  end

  test "test yahoojp expired?" do
    session[:y_expires_at] = DateTime.now.to_i - 1
    assert_equal true, yahoojp_expired?
    session[:y_expires_at] = DateTime.now.to_i + 1
    assert_equal false, yahoojp_expired?
  end

  test "test tax rate hash" do
    expected = {"0" => "０％", "5" => "５％", "8" => "８％", "10" => "１０％"}
    assert_equal expected, tax_rate_hash
  end

  test "test tax rate name" do
    assert_equal "０％", tax_rate_name(0)
    assert_equal "５％", tax_rate_name(5)
    assert_equal "８％", tax_rate_name(8)
    assert_equal "１０％", tax_rate_name(10)
  end

  test "test ope flg hash" do
    expected = {"" => "(空白)", "0" => "カス品", "1" => "商品"}
    assert_equal expected, ope_flg_hash
  end

  test "test ope flg name" do
    assert_equal "-", ope_flg_name(nil)
    assert_equal "-", ope_flg_name("")
    assert_equal "カス品", ope_flg_name(0)
    assert_equal "商品", ope_flg_name(1)
  end

  test "test custom percentage" do
    assert_equal nil, custom_percentage(nil)
    assert_equal nil, custom_percentage("Two2")
    assert_equal "(50%)", custom_percentage("One1")
  end

  test "test sold type hash" do
    expected = {"0" => "買い品", "1" => "売り品"}
    assert_equal expected, sold_type_hash
  end

  test "test sold type name" do
    assert_equal "買い品", sold_type_name(0)
    assert_equal "売り品", sold_type_name(1)
  end

  test "test ship type hash" do
    expected = {"0" => "元払い", "1" => "着払い"}
    assert_equal expected, ship_type_hash
  end

  test "test ship type name" do
    assert_equal "元払い", ship_type_name(0)
    assert_equal "着払い", ship_type_name(1)
  end

  test "test auction total cost" do
    @auction.price = 100
    @auction.tax_rate = nil
    @auction.payment_cost = nil
    @auction.shipment_cost = nil
    assert_equal 100 , auction_total_cost
    @auction.tax_rate = 5
    assert_equal 105 , auction_total_cost
    @auction.payment_cost = 10
    assert_equal 115 , auction_total_cost
    @auction.shipment_cost = 1000
    assert_equal 1115 , auction_total_cost
  end
  
  test "test commas" do
    @auction.price = 1
    assert_equal "1", commas(@auction.price.to_i)
    @auction.price = 1000
    assert_equal "1,000", commas(@auction.price.to_i)
    @auction.price = 1000000
    assert_equal "1,000,000", commas(@auction.price.to_i)
  end
  
  test "test hiffen" do
    @auction.shipment_code = 1234
    assert_equal "1234", hiffen(@auction.shipment_code.to_i)
    @auction.shipment_code = 12345
    assert_equal "1-2345", hiffen(@auction.shipment_code.to_i)
    @auction.shipment_code = 123456789
    assert_equal "1-2345-6789", hiffen(@auction.shipment_code.to_i)
  end
  
  test "test auction name" do
    assert_equal "OneOneOneOneOne 11111", auction_name(@auction.auction_id)
  end
  
  test "test auction hash" do
    expected = {"" => "(空白)", "One1" => "OneOneOneOneOne 11111"}
    assert_equal expected, auctions_hash
  end
  
  test "test form select hash 1" do
    form_select_hash(nil)
    expected = {"" => "(空白)"}
    assert_not_nil @categories
    assert_not_nil @brands
    assert_equal expected, @modus
    assert_not_nil @paymethods
    assert_not_nil @shipmethods
  end
  
  test "test form select hash 2" do
    form_select_hash("Two2")
    expected = {"" => "(空白)", "TwoTwo2" => "Second Name"}
    assert_not_nil @categories
    assert_not_nil @brands
    assert_equal expected, @modus
    assert_not_nil @paymethods
    assert_not_nil @shipmethods
  end
end