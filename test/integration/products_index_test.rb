#encoding: utf-8
require 'test_helper'

class ProductsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end
  
  test "index including pagination and new/show/edit/delete links" do
    log_in_as(@user)
    get products_path
    assert_template 'products/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_product_path, text: '新規'
    Product.paginate(page: 1, per_page: 15).each do |product|
      assert_select 'a[href=?]', product_path(product.product_id), text: '表示'
      assert_select 'a[href=?]', edit_product_path(product.product_id), text: '編集'
      assert_select 'a[href=?]', product_path(product.product_id), text: '削除', method: :delete
    end
    assert_difference 'Product.count', -1 do
      delete product_path(@product)
    end
  end
end
