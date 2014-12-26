#encoding: utf-8
require 'test_helper'

class ShipmentsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipment = shipments(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_shipment_path(@shipment)
    assert_template 'shipments/edit'
    patch shipment_path(@shipment), shipment: { #shipment_id:  "",
        shipmethod_id: nil,
        memo: 'メモメモメモ'}
    assert_template 'shipments/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_shipment_path(@shipment)
    assert_template 'shipments/edit'
    shipmethod_id = "ABCD"
    memo = 'メモメモメモ'
    patch shipment_path(@shipment), shipment: { #shipment_id:  "",
        shipmethod_id: shipmethod_id,
        memo: memo}
    assert_not flash.empty?
    assert_redirected_to shipments_path
    @shipment.reload
    assert_equal @shipment.shipmethod_id, shipmethod_id
    assert_equal @shipment.memo, memo
  end
end
