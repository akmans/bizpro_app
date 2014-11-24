# encoding: utf-8
require 'test_helper'

class ShipmethodsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @shipmethod = shipmethods(:one)
  end

  test "unsuccessful edit" do
    get edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    patch shipmethod_path(@shipmethod), shipmethod: { #shipmethod_id:  "",
                                                      shipmethod_name: ""}
    assert_template 'shipmethods/edit'
  end
  
  test "successful edit" do
    get edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    shipmethod_name = "てすと"
    patch shipmethod_path(@shipmethod), shipmethod: { #shipmethod_id:  "",
                                       shipmethod_name: shipmethod_name}
    assert_not flash.empty?
    assert_redirected_to shipmethods_path
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
  end
end
