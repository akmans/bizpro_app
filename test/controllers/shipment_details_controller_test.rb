#encoding: utf-8
require 'test_helper'

class ShipmentDetailsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipment = shipments(:one)
    @shipment_detail = shipment_details(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details",
                   { controller: "shipment_details", action: "index", shipment_shipment_id: "#{@shipment.shipment_id}" }
  end
 
#  test "should route to show" do
#    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}",
#                   { controller: "shipment_details", action: "show", id: "#{@shipment_detail.id}" }
#  end
 
  test "should route to new" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details/new",
                   { controller: "shipment_details", action: "new", shipment_shipment_id: "#{@shipment.shipment_id}" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: "/shipments/#{@shipment.shipment_id}/shipment_details", id: "#{@shipment.shipment_id}" },
                   { controller: "shipment_details", action: "create", shipment_shipment_id: "#{@shipment.shipment_id}" })
  end
 
  test "should route to edit" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}/edit",
                   { controller: "shipment_details", action: "edit", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}" },
                   { controller: "shipment_details", action: "update", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}" },
                   { controller: "shipment_details", action: "destroy", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, shipment_shipment_id: @shipment.shipment_id
    assert_response :success
    assert_select 'title', full_title_help('一覧,発送詳細')
    assert_not_nil assigns(:shipment_details)
  end
  
  test "should redirect index when not logged in" do
    get :index, shipment_shipment_id: @shipment.shipment_id
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    get :new, shipment_shipment_id: @shipment.shipment_id
    assert_response :success
    assert_select 'title', full_title_help('新規,発送詳細')
    assert_not_nil assigns(:shipment_detail)
  end
  
  test "should redirect new when not logged in" do
    get :new, shipment_shipment_id: @shipment.shipment_id
    assert_redirected_to login_url
  end

  # test action create
  test "should create shipment detail when logged in" do
    log_in_as(@user)
    assert_difference 'ShipmentDetail.count', 1 do
      post :create, shipment_shipment_id: @shipment.shipment_id,
           shipment_detail: { product_id: "test",
             ship_cost: 100,
             insured_cost: 10,
             custom_cost: 1,
             memo: "メモメモ"}
    end
    assert_redirected_to shipment_shipment_details_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'ShipmentDetail.count' do
      post :create, shipment_shipment_id: @shipment.shipment_id,
           shipment_detail: { product_id: "test",
             ship_cost: 100,
             insured_cost: 10,
             custom_cost: 1,
             memo: "メモメモ"}
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, shipment_shipment_id: @shipment.shipment_id, id: @shipment_detail
    assert_response :success
    assert_select 'title', full_title_help('編集,発送詳細')
    assert_not_nil assigns(:shipment_detail)
  end

  test "should redirect edit when not logged in" do
    get :edit, shipment_shipment_id: @shipment.shipment_id, id: @shipment_detail
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update shipment detail when logged in" do
    log_in_as(@user)
    product_id = "test"
    ship_cost = 100
    insured_cost = 10
    custom_cost = 1
    memo = "メモメモ"
    patch :update, shipment_shipment_id: @shipment, id: @shipment_detail,
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
    assert_redirected_to shipment_shipment_details_path
  end

  test "should redirect update when not logged in" do
    product_id = "test"
    ship_cost = 100
    insured_cost = 10
    custom_cost = 1
    memo = "メモメモ"
    patch :update, shipment_shipment_id: @shipment, id: @shipment_detail,
          shipment_detail: { product_id: product_id,
          ship_cost: ship_cost,
          insured_cost: insured_cost,
          custom_cost: custom_cost,
          memo: memo}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy shipment detail when logged in" do
    log_in_as(@user)
    assert_difference 'ShipmentDetail.count', -1 do
      delete :destroy, shipment_shipment_id: @shipment, id: @shipment_detail
    end
    assert_redirected_to shipment_shipment_details_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'ShipmentDetail.count' do
      delete :destroy, shipment_shipment_id: @shipment, id: @shipment_detail
    end
    assert_redirected_to login_url
  end
end