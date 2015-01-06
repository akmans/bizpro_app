# encoding: utf-8
require 'test_helper'

class ModusNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    xhr :get, new_brand_modu_path(brand_brand_id: @brand.brand_id)
    assert_template 'modus/new'
    xhr :post, brand_modus_path, modu: { #modu_id:  "",
#                                   brand_id: @brand.brand_id,
                                   modu_name: ""}
    assert_template 'modus/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    xhr :get, new_brand_modu_path(brand_brand_id: @brand.brand_id)
    assert_template 'modus/new'
    modu_name = "てすと"
    xhr :post, brand_modus_path, modu: { #modu_id:  "",
#                                   brand_id: @brand.brand_id,
                                   modu_name: modu_name}
    assert_not flash.empty?
    assert_not_nil assigns(:modus)
  end
end
