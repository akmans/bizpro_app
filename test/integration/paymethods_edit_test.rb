# encoding: utf-8
require 'test_helper'

class PaymethodsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @paymethod = paymethods(:one)
  end

  test "unsuccessful edit" do
    get edit_paymethod_path(@paymethod)
    assert_template 'paymethods/edit'
    patch paymethod_path(@paymethod), paymethod: { #paymethod_id:  "",
                                       paymethod_name: ""}
    assert_template 'paymethods/edit'
  end
  
  test "successful edit" do
    get edit_paymethod_path(@paymethod)
    assert_template 'paymethods/edit'
    paymethod_name = "てすと"
    patch paymethod_path(@paymethod), paymethod: { #paymethod_id:  "",
                                       paymethod_name: paymethod_name}
    assert_not flash.empty?
    assert_redirected_to paymethods_path
    @paymethod.reload
    assert_equal @paymethod.paymethod_name, paymethod_name
  end
end
