require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
  end

  def teardown
    log_out_help if logged_in_help?
  end

  # test log_in_help
  test "test log in help" do
    @user.remember
    log_in_help(@user)
    assert_equal @user.id, session[:user_id]
  end

  # test remember_help
  test "test remember help" do
    remember_help(@user)
    assert_equal @user.id, cookies.permanent.signed[:user_id]
    assert_equal @user.remember_token, cookies.permanent[:remember_token]
  end

  # test current_user_help?
  test "test current user help?" do
    remember_help(@user)
    assert current_user_help?(@user)
    assert_not current_user_help?(nil)
  end

  # test current_user_help
  test "current_user returns right user when session is nil" do
    remember_help(@user)
    assert_equal @user, current_user_help
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    remember_help(@user)
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user_help
  end

  # test logged_in_help?
  test "test logged in help?" do
    assert_not logged_in_help?
    remember_help(@user)
    assert logged_in_help?
  end

  # test forget_help
  test "test forget help" do
    remember_help(@user)
    forget_help(@user)
    assert_nil cookies.permanent.signed[:user_id]
    assert_nil cookies.permanent[:remember_token]
  end

  # test log_out_help
  test "test log out help" do
    remember_help(@user)
    log_out_help
    assert_nil assigns(:current_user)
    assert_nil session[:user_id]
  end

  # test store_location_help
  # nil
#  test "test store location" do
#    url = "http://ccc.ddd.com"
#    @request['url'] = url
#    store_location_help
#    assert_equal url, session[:forwarding_url]
#  end
end