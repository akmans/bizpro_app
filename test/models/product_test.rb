require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      # :product_id => 'Product_id',
      :product_name => 'Product Name',
      :is_domestic => 1
    )
  end

  # test @product
  test "should be valid" do
    assert @product.valid?
  end

  # test field product_id
  test "product_id should be allow blank" do
    @product.product_id = "    "
    assert @product.valid?
  end

  test "product_id should not be too long" do
    @product.product_id = "a" * 21
    assert_not @product.valid?
  end

  test "product_id should be unique" do
    @product.product_id = "test"
    duplicate_product = @product.dup
    duplicate_product.product_id = @product.product_id.upcase
    @product.save
    assert_not duplicate_product.valid?
  end

  # test field product_name
  test "product_name should be presence" do
    @product.product_name = "    "
    assert_not @product.valid?
  end

  test "product_name should not be too long" do
    @product.product_name = "a" * 201
    assert_not @product.valid?
  end

  # test field is_domestic
  test "is_domestic should be presence" do
    @product.is_domestic = nil
    assert_not @product.valid?
  end

  test "is_domestic should be numericality" do
    @product.is_domestic = "a"
    assert_not @product.valid?
  end

  test "is_domestic should be integer" do
    @product.is_domestic = 0.2
    assert_not @product.valid?
  end

  test "is_domestic should be more than 0" do
    @product.is_domestic = -1
    assert_not @product.valid?
  end

  test "is_domestic should be less than 3" do
    @product.is_domestic = 3
    assert_not @product.valid?
  end

  # test field category_id
  test "category_id should allow blank" do
    @product.category_id = nil
    assert @product.valid?
  end

  test "category_id should not be too long" do
    @product.category_id = "a" * 5
    assert_not @product.valid?
  end

  # test field brand_id
  test "brand_id should allow blank" do
    @product.brand_id = nil
    assert @product.valid?
  end

  test "brand_id should not be too long" do
    @product.brand_id = "a" * 5
    assert_not @product.valid?
  end

  # test field modu_id
  test "modu_id should allow blank" do
    @product.modu_id = nil
    assert @product.valid?
  end

  test "modu_id should not be too long" do
    @product.modu_id = "a" * 8
    assert_not @product.valid?
  end

  # test field memo
  test "memo should allow blank" do
    @product.memo = nil
    assert @product.valid?
  end

  test "memo should not be too long" do
    @product.memo = "a" * 201
    assert_not @product.valid?
  end

  # test ORDER BY
  test "order should be newest sold_date first" do
    assert_equal Product.first, products(:three)
  end

  # test as_hash
  test "should get data as hash" do
    @product.product_id = 'TEST'
    expected = {'TEST' => 'Product Name'}
    assert_equal expected, @product.as_hash
  end

  # test before_create
  test "should auto generate product id when id not presence" do
    @product.save
    @product.reload
    assert_not_nil @product.product_id
  end
end
