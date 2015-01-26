# encoding: utf-8
require 'test_helper'

class CategoriesIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @category = categories(:one)
  end
  
  test "index including pagination and edit/delete links" do
    log_in_as(@user)
    get categories_path
    assert_template 'categories/index'
    assert_select 'a[href=?]', new_category_path, remote: true, text: 'New'
    Category.paginate(page: 1, :per_page => 15).each do |category|
      assert_select 'a[href=?]', edit_category_path(category.category_id), remote: true, text: 'Edi'
      assert_select 'a[href=?]', category_path(category.category_id), remote: true, text: 'Del', method: :delete
    end
    assert_difference 'Category.count', -1 do
      xhr :delete, category_path(@category)
    end
  end
end
