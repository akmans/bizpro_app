#encoding: utf-8
require 'test_helper'

class CustomsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @custom = customs(:one)
  end
  
  test "index including pagination and new/show/edit/delete links" do
    log_in_as(@user)
    get customs_path
    assert_template 'customs/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_custom_path, text: '新規'
    Custom.paginate(page: 1, per_page: 15).each do |custom|
      assert_select 'a[href=?]', custom_path(custom.custom_id), text: '表示'
      assert_select 'a[href=?]', edit_custom_path(custom.custom_id), text: '編集'
      assert_select 'a[href=?]', custom_path(custom.custom_id), text: '削除', method: :delete
    end
    assert_difference 'Custom.count', -1 do
      delete custom_path(@custom)
    end
  end
end
