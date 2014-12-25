#encoding: utf-8
require 'test_helper'

class ProductsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    post products_path, product: { #product_id:  "",
                                product_name: "",
                                is_domestic: 0,
                                memo: "あいうえお"
    }
    assert_template 'products/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    product_name = "てすと"
    post products_path, product: { #product_id:  "",
                                product_name: product_name,
                                is_domestic: 0,
                                memo: "あいうえお"
    }
    assert_not flash.empty?
    assert_redirected_to products_path
  end
end
