# encoding: utf-8
require 'test_helper'

class ShipmethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end
  
  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title("一覧,発送方法,マスタ管理")
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
    assert_select 'title', full_title("新規,発送方法,マスタ管理")
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', 1 do
      post :create, shipmethod: { shipmethod_name: "Shipmethod Name" }
    end
    assert_redirected_to shipmethods_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Shipmethod.count' do
      post :create, shipmethod: { shipmethod_name: "Shipmethod Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, shipmethod_id: @shipmethod
    assert_response :success
    assert_select 'title', full_title("編集,発送方法,マスタ管理")
  end

  test "should redirect edit when not logged in" do
    get :edit, shipmethod_id: @shipmethod
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update shipmethod when logged in" do
    log_in_as(@user)
    shipmethod_name = "てすと"
    patch :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
    assert_redirected_to shipmethods_path
  end

  test "should redirect update when not logged in" do
    shipmethod_name = "てすと"
    patch :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', -1 do
      delete :destroy, shipmethod_id: @shipmethod
    end
    assert_redirected_to shipmethods_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Shipmethod.count' do
      delete :destroy, shipmethod_id: @shipmethod
    end
    assert_redirected_to login_url
  end
end
