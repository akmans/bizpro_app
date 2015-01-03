require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
#    remember(@user)
  end

  def teardown
    log_out_help if logged_in_help?
  end

  test "test log in" do
    @user.remember
    log_in_help(@user)
    assert_equal @user.id, session[:user_id]
  end

  test "test remember" do
    remember_help(@user)
    assert_equal @user.id, cookies.permanent.signed[:user_id]
    assert_equal @user.remember_token, cookies.permanent[:remember_token]
  end

  test "test current user?" do
    remember_help(@user)
    assert current_user_help?(@user)
    assert_not current_user_help?(nil)
  end

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

  test "test logged in?" do
    assert_not logged_in_help?
    remember_help(@user)
    assert logged_in_help?
  end

  test "test forget" do
    remember_help(@user)
    forget_help(@user)
    assert_nil cookies.permanent.signed[:user_id]
    assert_nil cookies.permanent[:remember_token]
  end

  test "test log out" do
    remember_help(@user)
    log_out_help
    assert_nil assigns(:current_user)
    assert_nil session[:user_id]
  end
end