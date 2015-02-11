# encoding: utf-8
require 'test_helper'

class ShipmentDetailsHelperTest < ActionView::TestCase
  def setup
    @shipment_detail = shipment_details(:one)
    @shipment = shipments(:one)
    @product = products(:one)
  end

  # test shipment_detail_cnt_help
  test "test shipment detail cnt help" do
    assert_equal 2, shipment_detail_cnt_help(@shipment.shipment_id)
    assert_equal 0, shipment_detail_cnt_help(nil)
  end

  # test shipment_detail_cnt_by_product_id_help
  test "test shipment detail cnt by product id help" do
    assert_equal 1, shipment_detail_cnt_by_product_id_help(@product.product_id)
    assert_equal 0, shipment_detail_cnt_by_product_id_help(nil)
  end

  # test shipment_product_cost_help
  test "test shipment product cost help" do
    assert_equal 111 * -100, shipment_product_cost_help(@shipment_detail)
    assert_equal 0, shipment_product_cost_help(nil)
  end
end