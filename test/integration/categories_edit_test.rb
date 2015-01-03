# encoding: utf-8
require 'test_helper'

class CategoriesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @category = categories(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    xhr :get, edit_category_path(@category)
    assert_template 'categories/edit'
    xhr :patch, category_path(@category), category: { category_name: ""}
    assert_template 'categories/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    xhr :get, edit_category_path(@category)
    assert_template 'categories/edit'
    category_name = "てすと"
    xhr :patch, category_path(@category), category: { category_name: category_name}
    assert_not flash.empty?
    assert_not_nil assigns(:categories)
    @category.reload
    assert_equal @category.category_name, category_name
  end
end
