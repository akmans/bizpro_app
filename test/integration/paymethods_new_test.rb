# encoding: utf-8
require 'test_helper'

class PaymethodsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_paymethod_path
    assert_template 'paymethods/new'
    post paymethods_path, paymethod: { #paymethod_id:  "",
                               paymethod_name: ""}
    assert_template 'paymethods/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_paymethod_path
    assert_template 'paymethods/new'
    paymethod_name = "てすと"
    post paymethods_path, paymethod: { #paymethod_id:  "",
                               paymethod_name: paymethod_name}
    assert_not flash.empty?
    assert_redirected_to paymethods_path
  end
end
