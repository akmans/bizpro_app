# encoding: utf-8
require 'test_helper'

class PaMapsHelperTest < ActionView::TestCase
  def setup
    @product = products(:two)
  end

  test "test pa_map auction cnt help" do
    assert_equal 1, pa_map_auction_cnt_help(@product.product_id)
    assert_equal 0, pa_map_auction_cnt_help(nil)
  end
end