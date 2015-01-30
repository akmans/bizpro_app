#encoding: utf-8
require 'test_helper'

class ShipmentDetailsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipment = shipments(:one)
    @shipment_detail = shipment_details(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, shipment_shipment_id: @shipment.shipment_id
    assert_response :success
    assert_select 'title', full_title_help('詳細一覧,発送')
    assert_not_nil assigns(:shipment_details)
    assert_template 'shipment_details/index'
    assert_select 'a[href=?]', new_shipment_shipment_detail_path, text: 'New'
    ShipmentDetail.where(shipment_id: @shipment.shipment_id).all.each do |sd|
      assert_select 'a[href=?]', edit_shipment_shipment_detail_path(id: sd.id), text: 'Edi'
      assert_select 'a[href=?]', shipment_shipment_detail_path(id: sd.id), text: 'Del', method: :delete
    end
  end

  test "should redirect index when not logged in" do
    get :index, shipment_shipment_id: @shipment.shipment_id
    assert_redirected_to login_url
  end

  # test show action
  # nil

  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new, shipment_shipment_id: @shipment.shipment_id
    assert_response :success
    assert_not_nil assigns(:shipment)
    assert_not_nil assigns(:shipment_detail)
  end

  test "get new should show message when not logged in" do
    xhr :get, :new, shipment_shipment_id: @shipment.shipment_id
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create shipment detail when logged in" do
    log_in_as(@user)
    assert_difference 'ShipmentDetail.count', 1 do
      xhr :post, :create, shipment_shipment_id: @shipment.shipment_id,
           shipment_detail: { product_id: "test",
             ship_cost: 100,
             insured_cost: 10,
             custom_cost: 1,
             memo: "メモメモ"}
    end
    assert_not flash.empty?
    assert_not_nil assigns(:shipment_details)
    assert_equal '作成完了しました。', flash[:success]
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'ShipmentDetail.count' do
      xhr :post, :create, shipment_shipment_id: @shipment.shipment_id,
           shipment_detail: { product_id: "test",
             ship_cost: 100,
             insured_cost: 10,
             custom_cost: 1,
             memo: "メモメモ"}
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, shipment_shipment_id: @shipment.shipment_id, id: @shipment_detail
    assert_response :success
    assert_not_nil assigns(:shipment_detail)
  end

  test "get edit should show message when not logged in" do
    xhr :get, :edit, shipment_shipment_id: @shipment.shipment_id, id: @shipment_detail
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update shipment detail when logged in" do
    log_in_as(@user)
    product_id = "test"
    ship_cost = 100
    insured_cost = 10
    custom_cost = 1
    memo = "メモメモ"
    xhr :patch, :update, shipment_shipment_id: @shipment, id: @shipment_detail,
          shipment_detail: { product_id: product_id,
          ship_cost: ship_cost,
          insured_cost: insured_cost,
          custom_cost: custom_cost,
          memo: memo}
    @shipment_detail.reload
    assert_equal @shipment_detail.product_id, product_id
    assert_equal @shipment_detail.ship_cost, ship_cost
    assert_equal @shipment_detail.insured_cost, insured_cost
    assert_equal @shipment_detail.custom_cost, custom_cost
    assert_equal @shipment_detail.memo, memo
    assert_not flash.empty?
    assert_not_nil assigns(:shipment_details)
    assert_equal '更新完了しました。', flash[:success]
  end

  test "patch update should show message when not logged in" do
    product_id = "test"
    ship_cost = 100
    insured_cost = 10
    custom_cost = 1
    memo = "メモメモ"
    xhr :patch, :update, shipment_shipment_id: @shipment, id: @shipment_detail,
          shipment_detail: { product_id: product_id,
          ship_cost: ship_cost,
          insured_cost: insured_cost,
          custom_cost: custom_cost,
          memo: memo}
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy shipment detail when logged in" do
    log_in_as(@user)
    assert_difference 'ShipmentDetail.count', -1 do
      xhr :delete, :destroy, shipment_shipment_id: @shipment, id: @shipment_detail
    end
    assert_not_nil assigns(:shipment_details)
    assert_not flash.empty?
    assert_equal '削除完了しました。', flash[:success]
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'ShipmentDetail.count' do
      xhr :delete, :destroy, shipment_shipment_id: @shipment, id: @shipment_detail
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end