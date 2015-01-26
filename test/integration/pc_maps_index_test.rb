# encoding: utf-8
require 'test_helper'

class PcMapsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end
  
  test "index including delete links" do
    @pc_map = PcMap.where(product_id: @product).first
    log_in_as(@user)
    get product_pc_maps_path(product_product_id: @product.product_id)
    assert_template 'pc_maps/index'
    assert_select 'a[href=?]', new_product_pc_map_path, remote: true, text: 'New'
    PcMap.where(product_id: @product_id).each do |pc_map|
      assert_select 'a[href=?]', product_pc_map_path(pc_map.custom_id), text: 'Del', remote: true, method: :delete
    end
    assert_difference 'PcMap.count', -1 do
      xhr :delete, product_pc_map_path(@product, @pc_map)
    end
  end
end
