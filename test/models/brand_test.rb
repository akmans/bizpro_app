require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @brand = Brand.new(:brand_id => 'b001', :brand_name => 'Brand Name')
  end
  
  test "should be valid" do
    assert @brand.valid?
  end
  
  test "brand_id should be presence" do
    @brand.brand_id = "    "
    assert_not @brand.valid?
  end
  
  test "brand_id should not be too long" do
    @brand.brand_id = "a" * 5
    assert_not @brand.valid?
  end
  
  test "brand_id should be unique" do
    duplicate_brand = @brand.dup
    duplicate_brand.brand_id = @brand.brand_id.upcase
    @brand.save
    assert_not duplicate_brand.valid?
  end
  
  test "brand_name should be presence" do
    @brand.brand_name = "    "
    assert_not @brand.valid?
  end
  
  test "brand_name should not be too long" do
    @brand.brand_name = "a" * 101
    assert_not @brand.valid?
  end
end
