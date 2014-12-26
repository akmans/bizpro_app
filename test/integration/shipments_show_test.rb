#encoding: utf-8
require 'test_helper'

class ShipmentsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipment = shipments(:two)
  end
  
  test "show including index links" do
    log_in_as(@user)
    get shipment_path(@shipment)
    assert_template 'shipments/show'
    assert_select 'a[href=?]', shipments_path, text: '戻る'
  end
end
