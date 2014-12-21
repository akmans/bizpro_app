# encoding: utf-8
require 'test_helper'

class CustomsHelperTest < ActionView::TestCase
  def setup
    @custom = customs(:one)
    @auction = auctions(:one)
  end

  test "test percentage hash" do
    expected = {
      ""   => "(空白)",
      "10" => "１０％",
      "20" => "２０％",
      "30" => "３０％",
      "40" => "４０％",
      "50" => "５０％",
      "60" => "６０％",
      "70" => "７０％",
      "80" => "８０％",
      "90" => "９０％"
    }
    assert_equal expected, percentage_hash
  end

  test "test percentage name" do
    assert_equal "１０％", percentage_name(10)
    assert_equal "２０％", percentage_name(20)
    assert_equal "３０％", percentage_name(30)
    assert_equal "４０％", percentage_name(40)
    assert_equal "５０％", percentage_name(50)
    assert_equal "６０％", percentage_name(60)
    assert_equal "７０％", percentage_name(70)
    assert_equal "８０％", percentage_name(80)
    assert_equal "９０％", percentage_name(90)
  end

  test "test is auction name" do
    assert_equal "-", is_auction_name(nil)
    assert_equal "-", is_auction_name(0)
    assert_equal "オークション品", is_auction_name(1)
  end

  test "test custom total cost" do
    @custom.is_auction = 0
    @custom.net_cost = 1000
    @custom.tax_cost = 100
    @custom.other_cost = 10
    assert_equal 1110, custom_total_cost
    @custom.is_auction = nil
    assert_equal 0, custom_total_cost
    @custom.is_auction = 1
    @custom.auction_id = "One1"
    @custom.percentage = 100
    assert_equal 123456, custom_total_cost
  end
end