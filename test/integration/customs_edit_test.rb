#encoding: utf-8
require 'test_helper'

class CustomsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @custom = customs(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_custom_path(@custom)
    assert_template 'customs/edit'
    patch custom_path(@custom), custom: { #custom_id:  "",
        custom_name: nil,
        memo: 'メモメモメモ'}
    assert_template 'customs/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_custom_path(@custom)
    assert_template 'customs/edit'
    custom_name = "てすと"
    is_auction = 0
    net_cost = 10
    tax_cost = 100
    other_cost = 1000
    memo = 'メモメモメモ'
    patch custom_path(@custom), custom: { #custom_id:  "",
        custom_name: custom_name,
        is_auction: is_auction,
        net_cost: net_cost,
        tax_cost: tax_cost,
        other_cost: other_cost,
        memo: memo}
    assert_not flash.empty?
    assert_redirected_to customs_path
    @custom.reload
    assert_equal @custom.custom_name, custom_name
    assert_equal @custom.is_auction, is_auction
    assert_equal @custom.net_cost, net_cost
    assert_equal @custom.tax_cost, tax_cost
    assert_equal @custom.other_cost, other_cost
    assert_equal @custom.memo, memo
  end
end
