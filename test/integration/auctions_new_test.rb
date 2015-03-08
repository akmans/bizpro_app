# encoding: utf-8
require 'test_helper'

class AuctionsNewTest < ActionDispatch::IntegrationTest
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
  end

  def teardown
    OmniAuth.config.mock_auth[:yahoojp] = nil
    yahoojp_log_out_help if yahoojp_logged_in_help?
  end

  test "should show yahoojp login button if not log in yahoojp" do
    log_in_as(@user)
    get new_auction_path
    assert_template 'auctions/new'
    assert_select 'a[href=?]', "/auth/yahoojp", text: 'Yahoo! JAPAN でlogin'
  end

  test "should redirect to /auth/:provider/callback if get /auth/:provider" do
    log_in_as(@user)
    get "/auth/yahoojp"
    assert_redirected_to "/auth/yahoojp/callback"
  end

  test "should render new after callback action" do
    log_in_as(@user)
    get "/auth/yahoojp/callback"
    assert_select 'a[href=?]', "/auth/yahoojp/logout", text: 'ログアウト'
    assert_select 'a[href=?]', "/auth/yahoojp/loaddata1", text: 'ロード買いデータ'
    assert_select 'a[href=?]', "/auth/yahoojp/loaddata2", text: 'ロード売りデータ'
  end

  test "should render new after logout action" do
    log_in_as(@user)
    get "/auth/yahoojp/logout"
    assert_template 'auctions/new'
    assert_select 'a[href=?]', "/auth/yahoojp", text: 'Yahoo! JAPAN でlogin'
  end
end
