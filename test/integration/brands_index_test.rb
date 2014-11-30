# encoding: utf-8
require 'test_helper'

class BrandsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end
  
  test "index including pagination and edit/delete links" do
    log_in_as(@user)
    get brands_path
    assert_template 'brands/index'
    assert_select 'div.pagination'
    Brand.paginate(page: 1, per_page: 15).each do |brand|
      assert_select 'a[href=?]', edit_brand_path(brand.brand_id), text: '編集'
      assert_select 'a[href=?]', brand_path(brand.brand_id), text: '削除', method: :delete
    end
    assert_difference 'Brand.count', -1 do
      delete brand_path(@brand)
    end
  end
end
