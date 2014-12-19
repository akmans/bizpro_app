# encoding: utf-8
require 'test_helper'

class ShipmethodsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_shipmethod_path
    assert_template 'shipmethods/new'
    post shipmethods_path, shipmethod: { #shipmethod_id:  "",
                               shipmethod_name: ""}
    assert_template 'shipmethods/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_shipmethod_path
    assert_template 'shipmethods/new'
    shipmethod_name = "てすと"
    post shipmethods_path, shipmethod: { #shipmethod_id:  "",
                                        ship_type: 1,
                                        shipmethod_name: shipmethod_name}
    assert_not flash.empty?
    assert_redirected_to shipmethods_path
  end
end
