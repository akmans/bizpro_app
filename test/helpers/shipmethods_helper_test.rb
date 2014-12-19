# encoding: utf-8
require 'test_helper'

class ShipmethodsHelperTest < ActionView::TestCase

  test "test ship type hash" do
    expected = {"0" => "国内", "1" => "海外"}
    assert_equal expected, ship_type_hash
  end

  test "test ship type name" do
    assert_equal "国内", ship_type_name(0)
    assert_equal "海外", ship_type_name(1)
  end
end