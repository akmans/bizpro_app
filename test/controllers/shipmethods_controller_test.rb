# encoding: utf-8
require 'test_helper'

class ShipmethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help("一覧,発送方法,マスタ管理")
    assert_not_nil assigns(:shipmethods)
    assert_template 'shipmethods/index'
    assert_select 'a[href=?]', new_shipmethod_path, text: 'New'
    Shipmethod.paginate(page: 1, per_page: 15).each do |shipmethod|
      assert_select 'a[href=?]', edit_shipmethod_path(shipmethod.shipmethod_id), text: 'Edi', remote: true
      assert_select 'a[href=?]', shipmethod_path(shipmethod.shipmethod_id), text: 'Del', remote: true, method: :delete
    end
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
    assert_not_nil assigns(:shipmethod)
  end

  test "should redirect new when not logged in" do
    xhr :get, :new
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', 1 do
      xhr :post, :create, shipmethod: { shipmethod_type: 1, shipmethod_name: "Shipmethod Name" }
    end
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
    assert_equal '作成完了しました。', flash[:success]
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Shipmethod.count' do
      post :create, shipmethod: { shipmethod_name: "Shipmethod Name" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, shipmethod_id: @shipmethod
    assert_response :success
    assert_not_nil assigns(:shipmethod)
  end

  test "should redirect edit when not logged in" do
    xhr :get, :edit, shipmethod_id: @shipmethod
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update shipmethod when logged in" do
    log_in_as(@user)
    shipmethod_name = "てすと"
    xhr :patch, :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
    assert_equal '更新完了しました。', flash[:success]
  end

  test "should redirect update when not logged in" do
    shipmethod_name = "てすと"
    xhr :patch, :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', -1 do
      xhr :delete, :destroy, shipmethod_id: @shipmethod
    end
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
    assert_equal '削除完了しました。', flash[:success]
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Shipmethod.count' do
      xhr :delete, :destroy, shipmethod_id: @shipmethod
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end