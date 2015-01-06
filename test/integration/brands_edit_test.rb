# encoding: utf-8
require 'test_helper'

class BrandsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    xhr :get, edit_brand_path(@brand)
    assert_template 'brands/edit'
    xhr :patch, brand_path(@brand), brand: { #brand_id:  "",
                                       brand_name: ""}
    assert_template 'brands/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    xhr :get, edit_brand_path(@brand)
    assert_template 'brands/edit'
    brand_name = "てすと"
    xhr :patch, brand_path(@brand), brand: { #brand_id:  "",
                                       brand_name: brand_name}
    assert_not flash.empty?
    assert_not_nil assigns(:brands)
    @brand.reload
    assert_equal @brand.brand_name, brand_name
  end
end
