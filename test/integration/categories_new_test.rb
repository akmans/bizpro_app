# encoding: utf-8
require 'test_helper'

class CategoriesNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  end

  test "unsuccessful create" do
    get new_category_path
    assert_template 'categories/new'
    post categories_path, category: { #category_id:  "",
                                      category_name: ""}
    assert_template 'categories/new'
  end
  
  test "successful create" do
    get new_category_path
    assert_template 'categories/new'
    category_name = "てすと"
    post categories_path, category: { #category_id:  "",
                                      category_name: category_name}
    assert_not flash.empty?
    assert_redirected_to categories_path
  end
end
