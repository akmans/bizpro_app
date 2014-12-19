#encoding: utf-8
require 'test_helper'

class AuctionsHelperTest < ActionView::TestCase

  def setup
    @auction = auctions(:one)
  end

  test "test tax rate hash" do
    expected = {"0" => "０％", "5" => "５％", "8" => "８％", "10" => "１０％"}
    assert_equal expected, tax_rate_hash
  end

  test "test tax rate name" do
    assert_equal "０％", tax_rate_name(0)
    assert_equal "５％", tax_rate_name(5)
    assert_equal "８％", tax_rate_name(8)
    assert_equal "１０％", tax_rate_name(10)
  end

  test "test sold type hash" do
    expected = {"0" => "買い品", "1" => "売り品"}
    assert_equal expected, sold_type_hash
  end

  test "test sold type name" do
    assert_equal "買い品", sold_type_name(0)
    assert_equal "売り品", sold_type_name(1)
  end

  test "test ship type hash" do
    expected = {"0" => "元払い", "1" => "着払い"}
    assert_equal expected, ship_type_hash
  end

  test "test ship type name" do
    assert_equal "元払い", ship_type_name(0)
    assert_equal "着払い", ship_type_name(1)
  end

  test "test total cost" do
    @auction.price = 100
    @auction.tax_rate = nil
    @auction.payment_cost = nil
    @auction.shipment_cost = nil
    assert_equal 100 , total_cost
    @auction.tax_rate = 5
    assert_equal 105 , total_cost
    @auction.payment_cost = 10
    assert_equal 115 , total_cost
    @auction.shipment_cost = 1000
    assert_equal 1115 , total_cost
  end
  
  test "test commas" do
    @auction.price = 1
    assert_equal "1", commas(@auction.price.to_i)
    @auction.price = 1000
    assert_equal "1,000", commas(@auction.price.to_i)
    @auction.price = 1000000
    assert_equal "1,000,000", commas(@auction.price.to_i)
  end
  
  test "test hiffen" do
    @auction.shipment_code = 1234
    assert_equal "1234", hiffen(@auction.shipment_code.to_i)
    @auction.shipment_code = 12345
    assert_equal "1-2345", hiffen(@auction.shipment_code.to_i)
    @auction.shipment_code = 123456789
    assert_equal "1-2345-6789", hiffen(@auction.shipment_code.to_i)
  end
end