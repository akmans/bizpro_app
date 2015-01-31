# encoding: utf-8
require 'test_helper'

class PcMapsHelperTest < ActionView::TestCase
  def setup
    @product = products(:two)
  end

  # test pc_map_custom_cnt_help
  test "test pc_map custom cnt help" do
    assert_equal 1, pc_map_custom_cnt_help(@product.product_id)
    assert_equal 0, pc_map_custom_cnt_help(nil)
  end
end