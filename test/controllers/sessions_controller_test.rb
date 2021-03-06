#encoding: utf-8
require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  # test index action
  # nil

  # test show action
  # nil

  # test new action
  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', full_title_help('ログイン')
  end

  # test create action
  test "should redirect to root path if success to create session" do
    post :create, session: { email: @user.email, password: "password" }
    assert_redirected_to root_url
  end

  test "should redirect to root path if failed to create session" do
    post :create, session: { email: @user.email, password: "wrong password" }
    assert_template 'sessions/new'
  end

  # test edit action
  # nil

  # test update action
  # nil

  # test destroy action
  test "should redirect to login path if log out" do
    delete :destroy
    assert_redirected_to login_path
  end
end