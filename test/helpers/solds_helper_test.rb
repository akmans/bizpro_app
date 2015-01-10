# encoding: utf-8
require 'test_helper'

class SoldsHelperTest < ActionView::TestCase
  def setup
    @sold = solds(:one)
  end

  test "test sold cnt help" do
    assert_equal 1, sold_cnt_help(@sold.product_id)
    assert_equal 0, sold_cnt_help(nil)
  end
end