# encoding: utf-8
require 'test_helper'

class ShipmethodsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/shipmethods",
                   { controller: "shipmethods", action: "index" }
  end
 
#  test "should route to show" do
#    assert_routing "/shipmethods/#{@shipmethod.shipmethod_id}",
#                   { controller: "shipmethods", action: "show", shipmethod_id: "#{@shipmethod.shipmethod_id}" }
#  end
 
  test "should route to new" do
    assert_routing "/shipmethods/new",
                   { controller: "shipmethods", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/shipmethods' },
                   { controller: "shipmethods", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/shipmethods/#{@shipmethod.shipmethod_id}/edit",
                   { controller: "shipmethods", action: "edit", shipmethod_id: "#{@shipmethod.shipmethod_id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/shipmethods/#{@shipmethod.shipmethod_id}" },
                   { controller: "shipmethods", action: "update", shipmethod_id: "#{@shipmethod.shipmethod_id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/shipmethods/#{@shipmethod.shipmethod_id}" },
                   { controller: "shipmethods", action: "destroy", shipmethod_id: "#{@shipmethod.shipmethod_id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help("一覧,発送方法,マスタ管理")
    assert_not_nil assigns(:shipmethods)
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
    assert_not_nil assigns(:shipmethod)
  end
  
  test "should redirect new when not logged in" do
    xhr :get, :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', 1 do
      xhr :post, :create, shipmethod: { shipmethod_type: 1, shipmethod_name: "Shipmethod Name" }
    end
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
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
    xhr :get, :edit, shipmethod_id: @shipmethod
    assert_response :success
    assert_not_nil assigns(:shipmethod)
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
    xhr :patch, :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
    shipmethod_name = "てすと"
    xhr :patch, :update, shipmethod_id: @shipmethod, shipmethod: { shipmethod_name: shipmethod_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy shipmethod when logged in" do
    log_in_as(@user)
    assert_difference 'Shipmethod.count', -1 do
      xhr :delete, :destroy, shipmethod_id: @shipmethod
    end
    assert_not_nil assigns(:shipmethods)
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Shipmethod.count' do
      xhr :delete, :destroy, shipmethod_id: @shipmethod
    end
    assert_redirected_to login_url
  end
end