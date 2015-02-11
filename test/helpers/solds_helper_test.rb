# encoding: utf-8
require 'test_helper'

class SoldsHelperTest < ActionView::TestCase
  def setup
    @sold = solds(:one)
  end

  # test sold_cnt_help
  test "test sold cnt help" do
    assert_equal 2, sold_cnt_help(@sold.product_id)
    assert_equal 0, sold_cnt_help(nil)
  end

  # test sold_total_price_help
  test "test sold total price help" do
    assert_equal 134500, sold_total_price_help(@sold)
    @sold.ship_charge = 50
    @sold.other_charge = 50
    assert_equal 134400, sold_total_price_help(@sold).to_i
  end
end