# encoding: utf-8
require 'test_helper'

class PaymethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @paymethod = paymethods(:one)
  end

  # test index action
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

  # test show action
  # nil

  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:paymethod)
  end
  
  test "get new should show message when not logged in" do
    xhr :get, :new
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', 1 do
      xhr :post, :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_not_nil assigns(:paymethods)
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'Paymethod.count' do
      xhr :post, :create, paymethod: { paymethod_name: "Paymethod Name" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, paymethod_id: @paymethod
    assert_response :success
    assert_not_nil assigns(:paymethod)
  end

  test "get edit should show message when not logged in" do
    xhr :get, :edit, paymethod_id: @paymethod
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update paymethod when logged in" do
    log_in_as(@user)
    paymethod_name = "てすと"
    xhr :patch, :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    @paymethod.reload
    assert_equal @paymethod.paymethod_name, paymethod_name
    assert_not_nil assigns(:paymethods)
  end

  test "patch update should show message when not logged in" do
    paymethod_name = "てすと"
    xhr :patch, :update, paymethod_id: @paymethod, paymethod: { paymethod_name: paymethod_name }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy paymethod when logged in" do
    log_in_as(@user)
    assert_difference 'Paymethod.count', -1 do
      xhr :delete, :destroy, paymethod_id: @paymethod
    end
    assert_not_nil assigns(:paymethods)
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'Paymethod.count' do
      xhr :delete, :destroy, paymethod_id: @paymethod
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end