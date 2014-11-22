# encoding: utf-8
require 'test_helper'

class BrandsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  end
  
  test "index including pagination" do
    get brands_path
    assert_template 'brands/index'
    assert_select 'div.pagination'
    Brand.paginate(page: 1, per_page: 15).each do |brand|
      assert_select 'a[href=?]', edit_brand_path(brand.brand_id), text: '編集'
    end
  end
end
