# encoding: utf-8
require 'test_helper'

class PaMapsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end
  
  test "index including delete links" do
    @pa_map = PaMap.where(product_id: @product).first
    log_in_as(@user)
    get product_pa_maps_path(product_product_id: @product.product_id)
    assert_template 'pa_maps/index'
    assert_select 'a[href=?]', new_product_pa_map_path, remote: true, text: 'New'
    PaMap.where(product_id: @product_id).each do |pa_map|
      assert_select 'a[href=?]', product_pa_map_path(pa_map.auction_id), text: 'Del', remote: true, method: :delete
    end
    assert_difference 'PaMap.count', -1 do
      xhr :delete, product_pa_map_path(@product, @pa_map)
    end
  end
end
