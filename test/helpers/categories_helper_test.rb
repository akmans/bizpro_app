# encoding: utf-8
require 'test_helper'

class CategoriesHelperTest < ActionView::TestCase
  def setup
    @category = categories(:one)
  end

  test "test category name help" do
    assert_equal "-", category_name_help(nil)
    assert_equal "-", category_name_help("    ")
    assert_equal @category.category_name, category_name_help(@category.category_id)
  end
  
  test "test category hash help" do
    assert_not_nil category_hash_help
  end
end