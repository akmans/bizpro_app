#encoding: utf-8
require 'test_helper'

class PaMapsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @pa_map = pa_maps(:one)
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :product_product_id => @product.product_id
    assert_response :success
    assert_select 'title', full_title_help('オークションリスト,商品')
    assert_not_nil assigns(:pa_maps)
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
    assert_not_nil assigns(:pa_map)
  end
  
  test "should redirect new when not logged in" do
    get :new, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test action create
  test "should create pa_map when logged in" do
    log_in_as(@user)
    assert_difference 'PaMap.count', 1 do
      xhr :post, :create, product_product_id: @product.product_id, pa_map: { auction_id: "Auction105" }
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pa_maps)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'PaMap.count' do
      xhr :post, :create, product_product_id: @product.product_id, modu: { auction_id: "Auction105" }
    end
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy pa_map when logged in" do
    log_in_as(@user)
    assert_difference 'PaMap.count', -1 do
      xhr :delete, :destroy, product_product_id: @product, auction_id: @pa_map
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pa_maps)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'PaMap.count' do
      xhr :delete, :destroy, product_product_id: @product, auction_id: @pa_map
    end
    assert_redirected_to login_url
  end
end
