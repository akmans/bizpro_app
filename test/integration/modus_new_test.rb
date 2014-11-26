# encoding: utf-8
require 'test_helper'

class ModusNewTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @brand = brands(:one)
  end

  test "unsuccessful create" do
    get new_brand_modu_path(brand_brand_id: @brand.brand_id)
    assert_template 'modus/new'
    post brand_modus_path, modu: { #modu_id:  "",
#                                   brand_id: @brand.brand_id,
                                   modu_name: ""}
    assert_template 'modus/new'
  end
  
  test "successful create" do
    get new_brand_modu_path(brand_brand_id: @brand.brand_id)
    assert_template 'modus/new'
    modu_name = "てすと"
    post brand_modus_path, modu: { #modu_id:  "",
#                                   brand_id: @brand.brand_id,
                                   modu_name: modu_name}
    assert_not flash.empty?
    assert_redirected_to brand_modus_path(brand_brand_id: @brand.brand_id)
  end
end
