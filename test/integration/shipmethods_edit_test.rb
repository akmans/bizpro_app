# encoding: utf-8
require 'test_helper'

class ShipmethodsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    patch shipmethod_path(@shipmethod), shipmethod: { #shipmethod_id:  "",
                                                      shipmethod_name: ""}
    assert_template 'shipmethods/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    shipmethod_name = "てすと"
    patch shipmethod_path(@shipmethod), shipmethod: { #shipmethod_id:  "",
                                        shipmethod_type: 1,
                                       shipmethod_name: shipmethod_name}
    assert_not flash.empty?
    assert_redirected_to shipmethods_path
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
  end
end
