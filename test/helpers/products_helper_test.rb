# encoding: utf-8
require 'test_helper'

class ProductsHelperTest < ActionView::TestCase

  test "test is domestic hash" do
    expected = {"0" => "海外", "1" => "国内"}
    assert_equal expected, is_domestic_hash
  end

  test "test is domestic name" do
    assert_equal "海外", is_domestic_name(0)
    assert_equal "国内", is_domestic_name(1)
  end
end