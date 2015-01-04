# encoding: utf-8
require 'test_helper'

class PcMapsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    xhr :get, new_product_pc_map_path(product_product_id: @product.product_id)
    assert_template 'pc_maps/new'
    xhr :post, product_pc_maps_path, pc_map: { custom_id: ""}
    assert_template 'pc_maps/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    xhr :get, new_product_pc_map_path(product_product_id: @product.product_id)
    assert_template 'pc_maps/new'
    xhr :post, product_pc_maps_path, pc_map: { custom_id: "C105"}
    assert_not flash.empty?
    assert_not_nil assigns(:pc_maps)
  end
end