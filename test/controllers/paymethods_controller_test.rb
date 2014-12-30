# encoding: utf-8
require 'test_helper'

class PaymethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @paymethod = paymethods(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/paymethods",
                   { controller: "paymethods", action: "index" }
  end
 
#  test "should route to show" do
#    assert_routing "/paymethods/#{@paymethod.paymethod_id}",
#                   { controller: "paymethods", action: "show", paymethod_id: "#{@paymethod.paymethod_id}" }
#  end
 
  test "should route to new" do
    assert_routing "/paymethods/new",
                   { controller: "paymethods", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/paymethods' },
                   { controller: "paymethods", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/paymethods/#{@paymethod.paymethod_id}/edit",
                   { controller: "paymethods", action: "edit", paymethod_id: "#{@paymethod.paymethod_id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/paymethods/#{@paymethod.paymethod_id}" },
                   { controller: "paymethods", action: "update", paymethod_id: "#{@paymethod.paymethod_id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/paymethods/#{@paymethod.paymethod_id}" },
                   { controller: "paymethods", action: "destroy", paymethod_id: "#{@paymethod.paymethod_id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title("一覧,支払い方法,マスタ管理")
    assert_not_nil assigns(:paymethods)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
    assert_select 'title', full_title("新規,支払い方法,マスタ管理")
    assert_not_nil assigns(:paymethod)
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', 1 do
      post :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_redirected_to paymethods_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Paymethod.count' do
      post :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, paymethod_id: @paymethod
    assert_response :success
    assert_select 'title', full_title("編集,支払い方法,マスタ管理")
    assert_not_nil assigns(:paymethod)
  end

  test "should redirect edit when not logged in" do
    get :edit, paymethod_id: @paymethod
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update paymethod when logged in" do
    log_in_as(@user)
    paymethod_name = "てすと"
    patch :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    @paymethod.reload
    assert_equal @paymethod.paymethod_name, paymethod_name
    assert_redirected_to paymethods_path
  end

  test "should redirect update when not logged in" do
    paymethod_name = "てすと"
    patch :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', -1 do
      delete :destroy, paymethod_id: @paymethod
    end
    assert_redirected_to paymethods_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Paymethod.count' do
      delete :destroy, paymethod_id: @paymethod
    end
    assert_redirected_to login_url
  end
end