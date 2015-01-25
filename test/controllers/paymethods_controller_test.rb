# encoding: utf-8
require 'test_helper'

class PaymethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @paymethod = paymethods(:one)
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help("一覧,支払い方法,マスタ管理")
    assert_not_nil assigns(:paymethods)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:paymethod)
  end
  
  test "should redirect new when not logged in" do
    xhr :get, :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', 1 do
      xhr :post, :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_not_nil assigns(:paymethods)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Paymethod.count' do
      xhr :post, :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, paymethod_id: @paymethod
    assert_response :success
    assert_not_nil assigns(:paymethod)
  end

  test "should redirect edit when not logged in" do
    xhr :get, :edit, paymethod_id: @paymethod
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update paymethod when logged in" do
    log_in_as(@user)
    paymethod_name = "てすと"
    xhr :patch, :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    @paymethod.reload
    assert_equal @paymethod.paymethod_name, paymethod_name
    assert_not_nil assigns(:paymethods)
  end

  test "should redirect update when not logged in" do
    paymethod_name = "てすと"
    xhr :patch, :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', -1 do
      xhr :delete, :destroy, paymethod_id: @paymethod
    end
    assert_not_nil assigns(:paymethods)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Paymethod.count' do
      xhr :delete, :destroy, paymethod_id: @paymethod
    end
    assert_redirected_to login_url
  end
end