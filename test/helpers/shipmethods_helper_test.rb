# encoding: utf-8
require 'test_helper'

class ShipmethodsHelperTest < ActionView::TestCase

  def setup
    @shipmethod = shipmethods(:one)
  end

  test "test shipmethod type hash" do
    expected = {"0" => "国内", "1" => "海外"}
    assert_equal expected, shipmethod_type_hash
  end

  test "test shipmethod type name" do
    assert_equal "国内", shipmethod_type_name(0)
    assert_equal "海外", shipmethod_type_name(1)
  end
  
  test "test shipmethod name help" do
    assert_equal "-", shipmethod_name_help(nil)
    assert_equal "First Name", shipmethod_name_help(@shipmethod.shipmethod_id)
  end
end