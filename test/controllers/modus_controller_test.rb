# encoding: utf-8
require 'test_helper'

class ModusControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @brand = brands(:one)
    @modu = modus(:one)
  end
  
  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_select 'title', full_title('一覧,モデル,マスタ管理')
  end
  
  test "should redirect index when not logged in" do
    get :index, :brand_brand_id => @brand.brand_id
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    get :new, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_select 'title', full_title('新規,モデル,マスタ管理')
  end
  
  test "should redirect new when not logged in" do
    get :new, :brand_brand_id => @brand.brand_id
    assert_redirected_to login_url
  end

  # test action create
  test "should create modu when logged in" do
    log_in_as(@user)
    assert_difference 'Modu.count', 1 do
      post :create, brand_brand_id: @brand.brand_id, modu: { modu_name: "Modu Name" }
    end
    assert_redirected_to brand_modus_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Modu.count' do
      post :create, brand_brand_id: @brand.brand_id, modu: { modu_name: "Modu Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, :brand_brand_id => @brand.brand_id, modu_id: @modu
    assert_response :success
    assert_select 'title', full_title('編集,モデル,マスタ管理')
  end

  test "should redirect edit when not logged in" do
    get :edit, :brand_brand_id => @brand.brand_id, modu_id: @modu
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update modu when logged in" do
    log_in_as(@user)
    modu_name = "てすと"
    patch :update, brand_brand_id: @brand, modu_id: @modu, modu: { modu_name: modu_name }
    @modu.reload
    assert_equal @modu.modu_name, modu_name
    assert_redirected_to brand_modus_path
  end

  test "should redirect update when not logged in" do
    modu_name = "てすと"
    patch :update, brand_brand_id: @brand, modu_id: @modu, modu: { modu_name: modu_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy modu when logged in" do
    log_in_as(@user)
    assert_difference 'Modu.count', -1 do
      delete :destroy, brand_brand_id: @brand, modu_id: @modu
    end
    assert_redirected_to brand_modus_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Modu.count' do
      delete :destroy, brand_brand_id: @brand, modu_id: @modu
    end
    assert_redirected_to login_url
  end
end
