#encoding: utf-8
require 'test_helper'

class ProductsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_product_path(@product)
    assert_template 'products/edit'
    patch product_path(@product), product: { #product_id:  "",
        product_name: nil,
        is_domestic: 1,
        memo: 'メモメモメモ'}
    assert_template 'products/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_product_path(@product)
    assert_template 'products/edit'
    product_name = "てすと"
    is_domestic = 1
    memo = 'メモメモメモ'
    patch product_path(@product), product: { #product_id:  "",
        product_name: product_name,
        is_domestic: is_domestic,
        memo: memo}
    assert_not flash.empty?
    assert_redirected_to products_path
    @product.reload
    assert_equal @product.product_name, product_name
    assert_equal @product.is_domestic, is_domestic
    assert_equal @product.memo, memo
  end
end
