# encoding: utf-8
require 'test_helper'

class ModusControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @brand = brands(:one)
    @modu = modus(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_select 'title', full_title_help('一覧,モデル,マスタ管理')
    assert_not_nil assigns(:modus)
  end

  test "should redirect index when not logged in" do
    get :index, :brand_brand_id => @brand.brand_id
    assert_redirected_to login_url
  end

  # test show action
  # nil

  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_not_nil assigns(:modu)
  end

  test "get new should show message when not logged in" do
    xhr :get, :new, :brand_brand_id => @brand.brand_id
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create modu when logged in" do
    log_in_as(@user)
    assert_difference 'Modu.count', 1 do
      xhr :post, :create, brand_brand_id: @brand.brand_id, modu: { modu_name: "Modu Name" }
    end
    assert_not flash.empty?
    assert_not_nil assigns(:modus)
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'Modu.count' do
      xhr :post, :create, brand_brand_id: @brand.brand_id, modu: { modu_name: "Modu Name" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, :brand_brand_id => @brand.brand_id, modu_id: @modu
    assert_response :success
    assert_not_nil assigns(:modu)
  end

  test "get edit should show message when not logged in" do
    xhr :get, :edit, :brand_brand_id => @brand.brand_id, modu_id: @modu
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update modu when logged in" do
    log_in_as(@user)
    modu_name = "てすと"
    xhr :patch, :update, brand_brand_id: @brand, modu_id: @modu, modu: { modu_name: modu_name }
    @modu.reload
    assert_equal @modu.modu_name, modu_name
    assert_not flash.empty?
    assert_not_nil assigns(:modus)
  end

  test "patch update should show message when not logged in" do
    modu_name = "てすと"
    xhr :patch, :update, brand_brand_id: @brand, modu_id: @modu, modu: { modu_name: modu_name }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy modu when logged in" do
    log_in_as(@user)
    assert_difference 'Modu.count', -1 do
      xhr :delete, :destroy, brand_brand_id: @brand, modu_id: @modu
    end
    assert_not flash.empty?
    assert_not_nil assigns(:modus)
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'Modu.count' do
      xhr :delete, :destroy, brand_brand_id: @brand, modu_id: @modu
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test ajax_modus action
  test "should get json data when logged in" do
    log_in_as(@user)
    xhr :get, :ajax_modus, brand_id: @brand
    assert_equal [@modu.as_json], JSON.parse(response.body)
  end

  test "get ajax_modus should show message when not logged in" do
    xhr :get, :ajax_modus, brand_id: @brand
    assert_equal 'Please log in.', flash[:danger]
  end
end