# encoding: utf-8
require 'test_helper'

class ShipmentsHelperTest < ActionView::TestCase

  def setup
    @shipment = shipments(:one)
  end

  # test shipment_cost_help
  test "test shipment cost help" do
    expected = -22100
    assert_equal expected, shipment_cost_help(@shipment.shipment_id)
  end
end