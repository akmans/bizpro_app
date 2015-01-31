require 'test_helper'

class PcMapTest < ActiveSupport::TestCase
  def setup
    @pc_map = PcMap.new(
      :custom_id => 'Custom_id',
      :product_id => 'Product_id'
    )
  end

  # test @pc_map
  test "should be valid" do
    assert @pc_map.valid?
  end

  # test field custom_id
  test "custom_id should be presence" do
    @pc_map.custom_id = "    "
    assert_not @pc_map.valid?
  end

  test "custom_id should not be too long" do
    @pc_map.custom_id = "a" * 21
    assert_not @pc_map.valid?
  end

  test "custom_id should be unique" do
    duplicate_pc_map = @pc_map.dup
    duplicate_pc_map.custom_id = @pc_map.custom_id.upcase
    @pc_map.save
    assert_not duplicate_pc_map.valid?
  end

  # test field product_id
  test "product_id should be presence" do
    @pc_map.product_id = "    "
    assert_not @pc_map.valid?
  end

  test "product_id should not be too long" do
    @pc_map.product_id = "a" * 21
    assert_not @pc_map.valid?
  end

  # test ORDER BY
  test "order should be newest created data first" do
    assert_equal PcMap.first, pc_maps(:one)
  end
end
