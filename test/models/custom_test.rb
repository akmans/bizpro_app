require 'test_helper'

class CustomTest < ActiveSupport::TestCase
  def setup
    @custom = Custom.new(:custom_id => 'Custom_id',
                         :custom_name => 'Custom Name',
                         :is_auction => 1,
                         :auction_id => 'Auction Id',
                         :net_cost => 0,
                         :tax_cost => 0,
                         :other_cost => 0
                        )
  end
  
  test "should be valid" do
    assert @custom.valid?
  end
  
  test "custom_id should be presence" do
    @custom.custom_id = "    "
    assert @custom.valid?
  end
  
  test "custom_id should not be too long" do
    @custom.custom_id = "a" * 21
    assert_not @custom.valid?
  end
  
  test "custom_id should be unique" do
    duplicate_custom = @custom.dup
    duplicate_custom.custom_id = @custom.custom_id.upcase
    @custom.save
    assert_not duplicate_custom.valid?
  end
  
  test "custom_name should be presence" do
    @custom.custom_name = "    "
    assert_not @custom.valid?
  end
  
  test "custom_name should not be too long" do
    @custom.custom_name = "a" * 201
    assert_not @custom.valid?
  end
  
  test "is_auction should be presence" do
    @custom.is_auction = nil
    assert_not @custom.valid?
  end
  
  test "is_auction should be numericality" do
    @custom.is_auction = "a"
    assert_not @custom.valid?
  end
  
  test "is_auction should be integer" do
    @custom.is_auction = 0.2
    assert_not @custom.valid?
  end
  
  test "is_auction should be more than 0" do
    @custom.is_auction = -1
    assert_not @custom.valid?
  end
  
  test "is_auction should be less than 2" do
    @custom.is_auction = 2
    assert_not @custom.valid?
  end
  
  test "auction_id should be allow blank" do
    @custom.auction_id = "    "
    assert @custom.valid?
  end
  
  test "auction_id should not be too long" do
    @custom.auction_id = "a" * 21
    assert_not @custom.valid?
  end

  test "net_cost should be allow blank" do
    @custom.net_cost = nil
    assert @custom.valid?
  end
  
  test "net_cost should be numericality" do
    @custom.net_cost = "a"
    assert_not @custom.valid?
  end
  
  test "tax_cost should be integer" do
    @custom.tax_cost = 1.2
    assert_not @custom.valid?
  end

  test "tax_cost should be presence" do
    @custom.tax_cost = nil
    assert @custom.valid?
  end
  
  test "tax_cost should be numericality" do
    @custom.tax_cost = "a"
    assert_not @custom.valid?
  end
  
  test "net_cost should be integer" do
    @custom.net_cost = 1.2
    assert_not @custom.valid?
  end

  test "other_cost should be presence" do
    @custom.other_cost = nil
    assert @custom.valid?
  end
  
  test "other_cost should be numericality" do
    @custom.other_cost = "a"
    assert_not @custom.valid?
  end
  
  test "other_cost should be integer" do
    @custom.other_cost = 1.2
    assert_not @custom.valid?
  end
  
  test "memo should allow blank" do
    @custom.memo = nil
    assert @custom.valid?
  end
  
  test "memo should not be too long" do
    @custom.memo = "a" * 201
    assert_not @custom.valid?
  end
end
