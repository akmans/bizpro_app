# encoding: utf-8
require 'test_helper'

class ModusEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @brand = brands(:one)
    @modu = modus(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    xhr :get, edit_brand_modu_path(@brand, @modu)
    assert_template 'modus/edit'
    xhr :patch, brand_modu_path(modu_id: @modu), modu: { #modu_id:  "",
                                          modu_name: ""}
    assert_template 'modus/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    xhr :get, edit_brand_modu_path(@brand, @modu)
    assert_template 'modus/edit'
    modu_name = "てすと"
    xhr :patch, brand_modu_path(modu_id: @modu), modu: { #modu_id:  "",
                                          modu_name: modu_name}
    assert_not flash.empty?
    assert_not_nil assigns(:modus)
    @modu.reload
    assert_equal @modu.modu_name, modu_name
  end
end
