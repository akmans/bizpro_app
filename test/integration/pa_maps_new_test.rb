# encoding: utf-8
require 'test_helper'

class PaMapsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    xhr :get, new_product_pa_map_path(product_product_id: @product.product_id)
    assert_template 'pa_maps/new'
    xhr :post, product_pa_maps_path, pa_map: { auction_id: ""}
    assert_template 'pa_maps/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    xhr :get, new_product_pa_map_path(product_product_id: @product.product_id)
    assert_template 'pa_maps/new'
    xhr :post, product_pa_maps_path, pa_map: { auction_id: "Auction105"}
    assert_not flash.empty?
    assert_not_nil assigns(:pa_maps)
  end
end