#encoding: utf-8
require 'test_helper'

class ProductsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @product = products(:two)
  end
  
  test "show including index links" do
    log_in_as(@user)
    get product_path(@product)
    assert_template 'products/show'
  end
end
