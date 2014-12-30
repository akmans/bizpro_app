require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  # test routes
  test "should route to new" do
    assert_routing "/login",
                   { controller: "sessions", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/login' },
                   { controller: "sessions", action: "create" })
  end

  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/logout" },
                   { controller: "sessions", action: "destroy" })
  end

  # test new action
  test "should get new" do
    get :new
    assert_response :success
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

  # test destroy action
  test "should redirect to login path if log out" do
    delete :destroy
    assert_redirected_to login_path
  end
end