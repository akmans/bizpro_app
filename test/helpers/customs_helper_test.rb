# encoding: utf-8
require 'test_helper'

class CustomsHelperTest < ActionView::TestCase
  def setup
    @custom = customs(:one)
    @custom2 = customs(:two)
    @auction = auctions(:one)
  end

  # test percentage_hash_help
  test "test percentage hash help" do
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
    assert_equal expected, percentage_hash_help
  end

  # test auction_percentage_hash_help
  test "test auction percentage hash help" do
    expected = {
      ""   => "(空白)",
      "10" => "１０％",
      "20" => "２０％",
      "30" => "３０％",
      "40" => "４０％",
      "50" => "５０％"}
    assert_equal expected, auction_percentage_hash_help(@custom2.custom_id, @custom2.auction_id)
  end

  # test percentage_name_help
  test "test percentage name help" do
    assert_equal "-", percentage_name_help(nil)
    assert_equal "１０％", percentage_name_help(10)
    assert_equal "２０％", percentage_name_help(20)
    assert_equal "３０％", percentage_name_help(30)
    assert_equal "４０％", percentage_name_help(40)
    assert_equal "５０％", percentage_name_help(50)
    assert_equal "６０％", percentage_name_help(60)
    assert_equal "７０％", percentage_name_help(70)
    assert_equal "８０％", percentage_name_help(80)
    assert_equal "９０％", percentage_name_help(90)
  end

  # test is_auction_name_help
  test "test is auction name help" do
    assert_equal "-", is_auction_name_help(nil)
    assert_equal "-", is_auction_name_help(0)
    assert_equal "オークション品", is_auction_name_help(1)
  end

  # test custom_total_cost_help
  test "test custom total cost help" do
    @custom.is_auction = 0
    @custom.net_cost = 1000
    @custom.tax_cost = 100
    @custom.other_cost = 10
    assert_equal 1110 * -1, custom_total_cost_help(@custom)
    @custom.is_auction = nil
    assert_equal 0, custom_total_cost_help(@custom)
    @custom.is_auction = 1
    @custom.auction_id = "One1"
    @custom.percentage = 100
    assert_equal -123400, custom_total_cost_help(@custom)
  end

  # test custom_name_help
  test "test custom name help" do
    assert_equal @custom.custom_name, custom_name_help(@custom.custom_id)
  end

  # test customs_hash_help
  test "test custom hash help" do
    expected = {"" => "(空白)", "One1" => "CustomName", "Two2" => "CustomName"}
    assert_equal expected, customs_hash_help
  end
end