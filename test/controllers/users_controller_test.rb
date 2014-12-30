require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  # test routes
  test "should route to index" do
    assert_routing "/users",
                   { controller: "users", action: "index" }
  end
 
  test "should route to show" do
    assert_routing "/users/#{@user.id}",
                   { controller: "users", action: "show", id: "#{@user.id}" }
  end
 
  test "should route to new" do
    assert_routing "/signup",
                   { controller: "users", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/users' },
                   { controller: "users", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/users/#{@user.id}/edit",
                   { controller: "users", action: "edit", id: "#{@user.id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/users/#{@user.id}" },
                   { controller: "users", action: "update", id: "#{@user.id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/users/#{@user.id}" },
                   { controller: "users", action: "destroy", id: "#{@user.id}" })
  end
  
  # test index action
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  # test new action
  test "should get new" do
    get :new
    assert_response :success
  end

  # test edit action
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  # test update action
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # test destroy action
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
end
