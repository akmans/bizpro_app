require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(:category_name => 'Category Name')
  end
  
  test "should be valid" do
    assert @category.valid?
  end
  
  test "category_id should be allow blank" do
    @category.category_id = "    "
    assert @category.valid?
  end
  
  test "category_id should not be too long" do
    @category.category_id = "a" * 5
    assert_not @category.valid?
  end
  
  test "category_id should be unique" do
    @category.category_id = "test"
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
  
  test "order should be miximum ID first" do
    assert_equal Category.first, categories(:one)
  end
  
  test "should get data as hash" do
    @category.category_id = 'TEST'
    expected = {'TEST' => 'Category Name'}
    assert_equal expected, @category.as_hash
  end
  
  test "should auto generate category id when id not presence" do
    @category.save
    @category.reload
    assert_not_nil @category.category_id
  end
end
