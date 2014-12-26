#encoding: utf-8
require 'test_helper'

class ShipmentsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipment = shipments(:one)
  end
  
  test "index including pagination and new/show/edit/delete links" do
    log_in_as(@user)
    get shipments_path
    assert_template 'shipments/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_shipment_path, text: '新規'
    Shipment.paginate(page: 1, per_page: 15).each do |shipment|
      assert_select 'a[href=?]', shipment_path(shipment.shipment_id), text: '表示'
      assert_select 'a[href=?]', edit_shipment_path(shipment.shipment_id), text: '編集'
      assert_select 'a[href=?]', shipment_path(shipment.shipment_id), text: '削除', method: :delete
    end
    assert_difference 'Shipment.count', -1 do
      delete shipment_path(@shipment)
    end
  end
end
