require 'test_helper'

class PaMapTest < ActiveSupport::TestCase
  def setup
    @pa_map = PaMap.new(
      :auction_id => 'Auction_id',
      :product_id => 'Product_id'
    )
  end
  
  test "should be valid" do
    assert @pa_map.valid?
  end
  
  test "auction_id should be presence" do
    @pa_map.auction_id = "    "
    assert_not @pa_map.valid?
  end
  
  test "auction_id should not be too long" do
    @pa_map.auction_id = "a" * 21
    assert_not @pa_map.valid?
  end
  
  test "auction_id should be unique" do
    duplicate_pa_map = @pa_map.dup
    duplicate_pa_map.auction_id = @pa_map.auction_id.upcase
    @pa_map.save
    assert_not duplicate_pa_map.valid?
  end
  
  test "product_id should be presence" do
    @pa_map.product_id = "    "
    assert_not @pa_map.valid?
  end
  
  test "product_id should not be too long" do
    @pa_map.product_id = "a" * 21
    assert_not @pa_map.valid?
  end
  
  test "order should be newest created data first" do
    assert_equal PaMap.first, pa_maps(:one)
  end
end