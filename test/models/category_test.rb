require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @category = Category.new(:category_id => 'C001', :category_name => 'Category Name')
  end
  
  test "should be valid" do
    assert @category.valid?
  end
  
  test "category_id should be presence" do
    @category.category_id = "    "
    assert_not @category.valid?
  end
  
  test "category_id should not be too long" do
    @category.category_id = "a" * 5
    assert_not @category.valid?
  end
  
  test "category_id should be unique" do
    duplicate_category = @category.dup
    duplicate_category.category_id = @category.category_id.upcase
    @category.save
    assert_not duplicate_category.valid?
  end
  
  test "category_name should be presence" do
    @category.category_name = "    "
    assert_not @category.valid?
  end
  
  test "category_name should not be too long" do
    @category.category_name = "a" * 101
    assert_not @category.valid?
  end
end
