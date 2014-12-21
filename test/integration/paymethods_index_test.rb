# encoding: utf-8
require 'test_helper'

class PaymethodsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @paymethod = paymethods(:one)
  end
  
  test "index including pagination and edit/delete links" do
    log_in_as(@user)
    get paymethods_path
    assert_template 'paymethods/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_paymethod_path, text: '新規'
    Paymethod.paginate(page: 1, per_page: 15).each do |paymethod|
      assert_select 'a[href=?]', edit_paymethod_path(paymethod.paymethod_id), text: '編集'
      assert_select 'a[href=?]', paymethod_path(paymethod.paymethod_id), text: '削除', method: :delete
    end
    assert_difference 'Paymethod.count', -1 do
      delete paymethod_path(@paymethod)
    end
  end
end
