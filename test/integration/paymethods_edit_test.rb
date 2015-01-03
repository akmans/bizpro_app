# encoding: utf-8
require 'test_helper'

class PaymethodsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @paymethod = paymethods(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    xhr :get, edit_paymethod_path(@paymethod)
    assert_template 'paymethods/edit'
    xhr :patch, paymethod_path(@paymethod), paymethod: { paymethod_name: ""}
    assert_template 'paymethods/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    xhr :get, edit_paymethod_path(@paymethod)
    assert_template 'paymethods/edit'
    paymethod_name = "てすと"
    xhr :patch, paymethod_path(@paymethod), paymethod: { paymethod_name: paymethod_name}
    assert_not flash.empty?
    @paymethod.reload
    assert_equal @paymethod.paymethod_name, paymethod_name
  end
end
