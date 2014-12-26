#encoding: utf-8
require 'test_helper'

class ShipmentsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_shipment_path
    assert_template 'shipments/new'
    post shipments_path, shipment: { #shipment_id:  "",
                                shipmethod_id: "",
                                memo: "あいうえお"
    }
    assert_template 'shipments/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_shipment_path
    assert_template 'shipments/new'
    shipmethod_id = "ABCD"
    post shipments_path, shipment: { #shipment_id:  "",
                                shipmethod_id: shipmethod_id,
                                memo: "あいうえお"
    }
    assert_not flash.empty?
    assert_redirected_to shipments_path
  end
end
