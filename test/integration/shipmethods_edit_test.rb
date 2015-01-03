# encoding: utf-8
require 'test_helper'

class ShipmethodsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    xhr :get, edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    xhr :patch, shipmethod_path(@shipmethod), shipmethod: { shipmethod_type: 1, shipmethod_name: ""}
    assert_template 'shipmethods/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    xhr :get, edit_shipmethod_path(@shipmethod)
    assert_template 'shipmethods/edit'
    shipmethod_name = "てすと"
    xhr :patch, shipmethod_path(@shipmethod), shipmethod: { shipmethod_type: 1, shipmethod_name: shipmethod_name}
    assert_not flash.empty?
    @shipmethod.reload
    assert_equal @shipmethod.shipmethod_name, shipmethod_name
    assert_not_nil assigns(:shipmethods)
  end
end
