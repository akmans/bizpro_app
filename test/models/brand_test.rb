require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  def setup
    @brand = Brand.new(:brand_name => 'Brand Name')
  end

  # test @brand
  test "should be valid" do
    assert @brand.valid?
  end

  # test field brand_id
  test "brand_id should be allow blank" do
    @brand.brand_id = "    "
    assert @brand.valid?
  end

  test "brand_id should not be too long" do
    @brand.brand_id = "a" * 5
    assert_not @brand.valid?
  end

  test "brand_id should be unique" do
    @brand.brand_id = "b001"
    duplicate_brand = @brand.dup
    duplicate_brand.brand_id = @brand.brand_id.upcase
    @brand.save
    assert_not duplicate_brand.valid?
  end

  # test field brand_name
  test "brand_name should be presence" do
    @brand.brand_name = "    "
    assert_not @brand.valid?
  end

  test "brand_name should not be too long" do
    @brand.brand_name = "a" * 101
    assert_not @brand.valid?
  end

  # test ORDER BY
  test "order should be miximum ID first" do
    assert_equal Brand.first, brands(:one)
  end

  # test association
  test "associated modus should be destroyed" do
    @brand.save
    @brand.modus.create!(modu_id: "M001001", modu_name: "Model Name M001001")
    assert_difference 'Modu.count', -1 do
      @brand.destroy
    end
  end

  # test as_hash
  test "should get data as hash" do
    @brand.brand_id = 'TEST'
    expected = {'TEST' => 'Brand Name'}
    assert_equal expected, @brand.as_hash
  end

  # test before_create
  test "should auto generate brand id when id not presence" do
    @brand.save
    @brand.reload
    assert_not_nil @brand.brand_id
  end
end
