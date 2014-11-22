# encoding: utf-8
require 'test_helper'

class BrandsNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  end

  test "unsuccessful create" do
    get new_brand_path
    assert_template 'brands/new'
    post brands_path, brand: { #brand_id:  "",
                               brand_name: ""}
    assert_template 'brands/new'
  end
  
  test "successful create" do
    get new_brand_path
    assert_template 'brands/new'
    brand_name = "てすと"
    post brands_path, brand: { #brand_id:  "",
                               brand_name: brand_name}
    assert_not flash.empty?
    assert_redirected_to brands_path
  end
end
