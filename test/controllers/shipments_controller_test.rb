#encoding: utf-8
require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipment = shipments(:two)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help('一覧,発送')
    assert_not_nil assigns(:shipments)
    assert_template 'shipments/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_shipment_path, text: 'New'
    Shipment.paginate(page: 1, per_page: 15).each do |shipment|
      assert_select 'a[href=?]', shipment_path(shipment.shipment_id), text: 'Dis'
      assert_select 'a[href=?]', edit_shipment_path(shipment.shipment_id), text: 'Edi'
      assert_select 'a[href=?]', shipment_path(shipment.shipment_id), text: 'Del', method: :delete
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
    get :new
    assert_response :success
    assert_select 'title', full_title_help('新規,発送')
    assert_not_nil assigns(:shipment)
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test create action
  test "should create shipment when logged in" do
    log_in_as(@user)
    assert_difference 'Shipment.count', 1 do
      post :create, shipment: { shipment_name: "Shipment Name",
                              shipmethod_id: "ZZZ1"}
    end
    assert_redirected_to shipments_path
    assert_equal '作成完了しました。', flash[:success]
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Shipment.count' do
      post :create, shipment: { shipment_name: "Shipment Name",
                              shipmethod_id: "ZZZ1"}
    end
    assert_redirected_to login_url
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, shipment_id: @shipment
    assert_response :success
    assert_select 'title', full_title_help('編集,発送')
    assert_not_nil assigns(:shipment)
  end

  test "should redirect edit when not logged in" do
    get :edit, shipment_id: @shipment
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test update action
  test "should update shipment when logged in" do
    log_in_as(@user)
    shipmethod_id = "ZZZ1"
    sent_date = Date.today
    arrived_date = Date.today
    memo = 'メモメモメモ'
    patch :update, shipment_id: @shipment, \
          shipment: { shipmethod_id: shipmethod_id,
                     sent_date: sent_date,
                     arrived_date: arrived_date,
                     memo: memo
          }
    @shipment.reload
    assert_equal @shipment.shipmethod_id, shipmethod_id
    assert_equal @shipment.sent_date, sent_date
    assert_equal @shipment.arrived_date, arrived_date
    assert_equal @shipment.memo, memo
    assert_redirected_to shipments_path
    assert_equal '更新完了しました。', flash[:success]
  end

  test "should redirect update when not logged in" do
    shipmethod_id = "ZZZ1"
    sent_date = Date.today
    arrived_date = Date.today
    memo = 'メモメモメモ'
    patch :update, shipment_id: @shipment, \
          shipment: { shipmethod_id: shipmethod_id,
                     sent_date: sent_date,
                     arrived_date: arrived_date,
                     memo: memo
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test destory action
  test "should destroy shipment when logged in" do
    log_in_as(@user)
    assert_difference 'Shipment.count', -1 do
      delete :destroy, shipment_id: @shipment
    end
    assert_redirected_to shipments_path
    assert_equal '削除完了しました。', flash[:success]
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Shipment.count' do
      delete :destroy, shipment_id: @shipment
    end
    assert_redirected_to login_url
  end
end