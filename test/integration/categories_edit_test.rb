# encoding: utf-8
require 'test_helper'

class CategoriesEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @category = categories(:one)
  end

  test "unsuccessful edit" do
    get edit_category_path(@category)
    assert_template 'categories/edit'
    patch category_path(@category), category: { #category_id:  "",
                                                category_name: ""}
    assert_template 'categories/edit'
  end
  
  test "successful edit" do
    get edit_category_path(@category)
    assert_template 'categories/edit'
    category_name = "てすと"
    patch category_path(@category), category: { #category_id:  "",
                                                category_name: category_name}
    assert_not flash.empty?
    assert_redirected_to categories_path
    @category.reload
    assert_equal @category.category_name, category_name
  end
end
