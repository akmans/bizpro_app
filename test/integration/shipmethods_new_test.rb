# encoding: utf-8
require 'test_helper'

class ShipmethodsNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  end

  test "unsuccessful create" do
    get new_shipmethod_path
    assert_template 'shipmethods/new'
    post shipmethods_path, shipmethod: { #shipmethod_id:  "",
                               shipmethod_name: ""}
    assert_template 'shipmethods/new'
  end
  
  test "successful create" do
    get new_shipmethod_path
    assert_template 'shipmethods/new'
    shipmethod_name = "てすと"
    post shipmethods_path, shipmethod: { #shipmethod_id:  "",
                               shipmethod_name: shipmethod_name}
    assert_not flash.empty?
    assert_redirected_to shipmethods_path
  end
end
