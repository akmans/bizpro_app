# encoding: utf-8
require 'test_helper'

class ProductsHelperTest < ActionView::TestCase
  def setup
    @product = products(:one)
  end

  test "test is domestic hash help" do
    expected = {"0" => "海外", "1" => "国内", "2" => "発送中"}
    assert_equal expected, is_domestic_hash_help
  end

  test "test is domestic name help" do
    assert_equal "海外", is_domestic_name_help(0)
    assert_equal "国内", is_domestic_name_help(1)
  end

  test "test product name help" do
    assert_equal '-', product_name_help(nil)
    assert_equal @product.product_name, product_name_help(@product.product_id)
  end
  
  test "test product hash help" do
    assert_not_nil products_hash_help
  end
end