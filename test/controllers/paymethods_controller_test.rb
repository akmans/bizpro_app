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
    assert_select 'title', full_title("一覧,支払い方法,マスタ管理")
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
