# encoding: utf-8
require 'test_helper'

class ModusIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:brand_B101)
    @modu = modus(:modu_M101101)
  end
  
  test "index including pagination and edit/delete links" do
    log_in_as(@user)
    get brand_modus_path(brand_brand_id: @brand.brand_id)
    assert_template 'modus/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_brand_modu_path, text: '新規'
    Modu.where(brand_id: @brand.brand_id).paginate(page: 1, per_page: 15).each do |modu|
      assert_select 'a[href=?]', edit_brand_modu_path(modu_id: modu.modu_id), text: '編集'
      assert_select 'a[href=?]', brand_modu_path(modu_id: modu.modu_id), text: '削除', method: :delete
    end
    assert_difference 'Modu.count', -1 do
      delete brand_modu_path(@brand, @modu)
    end
  end
end
