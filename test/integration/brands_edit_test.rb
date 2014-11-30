# encoding: utf-8
require 'test_helper'

class BrandsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_brand_path(@brand)
    assert_template 'brands/edit'
    patch brand_path(@brand), brand: { #brand_id:  "",
                                       brand_name: ""}
    assert_template 'brands/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_brand_path(@brand)
    assert_template 'brands/edit'
    brand_name = "てすと"
    patch brand_path(@brand), brand: { #brand_id:  "",
                                       brand_name: brand_name}
    assert_not flash.empty?
    assert_redirected_to brands_path
    @brand.reload
    assert_equal @brand.brand_name, brand_name
  end
end
