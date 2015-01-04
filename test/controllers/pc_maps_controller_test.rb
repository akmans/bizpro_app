#encoding: utf-8
require 'test_helper'

class PcMapsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @pc_map = pc_maps(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/products/#{@product.product_id}/pc_maps",
                   { controller: "pc_maps", action: "index", product_product_id: "#{@product.product_id}" }
  end

  test "should route to new" do
    assert_routing "/products/#{@product.product_id}/pc_maps/new",
                   { controller: "pc_maps", action: "new", product_product_id: "#{@product.product_id}" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: "/products/#{@product.product_id}/pc_maps", product_product_id: "#{@product.product_id}" },
                   { controller: "pc_maps", action: "create", product_product_id: "#{@product.product_id}" })
  end

  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}/pc_maps/#{@pc_map.custom_id}" },
                   { controller: "pc_maps", action: "destroy", product_product_id: "#{@product.product_id}", custom_id: "#{@pc_map.custom_id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :product_product_id => @product.product_id
    assert_response :success
    assert_select 'title', full_title_help('カスタムリスト,商品')
    assert_not_nil assigns(:pc_maps)
  end
  
  test "should redirect index when not logged in" do
    get :index, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new, :product_product_id => @product.product_id
    assert_response :success
    assert_not_nil assigns(:pc_map)
  end
  
  test "should redirect new when not logged in" do
    get :new, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test action create
  test "should create pc_map when logged in" do
    log_in_as(@user)
    assert_difference 'PcMap.count', 1 do
      xhr :post, :create, product_product_id: @product.product_id, pc_map: { custom_id: "C105" }
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pc_maps)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'PcMap.count' do
      xhr :post, :create, product_product_id: @product.product_id, modu: { custom_id: "C105" }
    end
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy pc_map when logged in" do
    log_in_as(@user)
    assert_difference 'PcMap.count', -1 do
      xhr :delete, :destroy, product_product_id: @product, custom_id: @pc_map
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pc_maps)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'PcMap.count' do
      xhr :delete, :destroy, product_product_id: @product, custom_id: @pc_map
    end
    assert_redirected_to login_url
  end
end
