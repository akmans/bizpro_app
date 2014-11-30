# encoding: utf-8
require 'test_helper'

class CategoriesNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_category_path
    assert_template 'categories/new'
    post categories_path, category: { #category_id:  "",
                                      category_name: ""}
    assert_template 'categories/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_category_path
    assert_template 'categories/new'
    category_name = "てすと"
    post categories_path, category: { #category_id:  "",
                                      category_name: category_name}
    assert_not flash.empty?
    assert_redirected_to categories_path
  end
end
