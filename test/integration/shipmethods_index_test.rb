# encoding: utf-8
require 'test_helper'

class ShipmethodsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @shipmethod = shipmethods(:one)
  end
  
  test "index including pagination and edit/delete links" do
    log_in_as(@user)
    get shipmethods_path
    assert_template 'shipmethods/index'
    assert_select 'a[href=?]', new_shipmethod_path, text: 'New'
    Shipmethod.paginate(page: 1, per_page: 15).each do |shipmethod|
      assert_select 'a[href=?]', edit_shipmethod_path(shipmethod.shipmethod_id), text: 'Edi', remote: true
      assert_select 'a[href=?]', shipmethod_path(shipmethod.shipmethod_id), text: 'Del', remote: true, method: :delete
    end
    assert_difference 'Shipmethod.count', -1 do
      xhr :delete, shipmethod_path(@shipmethod)
    end
  end
end
