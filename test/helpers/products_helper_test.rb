# encoding: utf-8
require 'test_helper'

class ProductsHelperTest < ActionView::TestCase
  def setup
    @product = products(:one)
    @product3 = products(:three)
  end

  # test product_name_help
  test "test product name help" do
    assert_equal '-', product_name_help(nil)
    assert_equal @product.product_name, product_name_help(@product.product_id)
  end

  # test products_hash_help
  test "test product hash help" do
    expected = {"" => "(空白)", "Two2" => "MyString"}
    assert_equal expected, products_hash_help
    assert_equal expected, products_hash_help("Two2")
    expected.merge!({"One1" => "MyString"})
    assert_equal expected, products_hash_help("One1")
  end

  # test product_total_cost_help
#  test "test product total cost help" do
#    assert_equal 0, product_total_cost_help(nil)
#    assert_equal 134500 * -1, product_total_cost_help(@product.product_id)
#  end

  # test product_total_sold_price_help
#  test "test product total sold price help" do
#    assert_equal 0, product_total_sold_price_help(nil)
#    assert_equal 269000, product_total_sold_price_help(@product.product_id).to_i
#    assert_equal 100, product_total_sold_price_help(@product3.product_id).to_i
#  end

  # test profit_help
#  test "test profit help" do
#    assert_equal 0, profit_help(nil)
#    assert_equal 134500, profit_help(@product.product_id)
#    assert_equal 0, profit_help(@product3.product_id)
#  end

  # test profit_rate_help
#  test "test profit rate help" do
#    assert_equal 0, profit_rate_help(nil)
#    assert_equal 100, profit_rate_help(@product.product_id)
#    assert_equal 0, profit_rate_help(@product3.product_id)
#  end
end