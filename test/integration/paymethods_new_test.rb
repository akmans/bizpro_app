# encoding: utf-8
require 'test_helper'

class PaymethodsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    xhr :get, new_paymethod_path
    assert_template 'paymethods/new'
    xhr :post, paymethods_path, paymethod: { paymethod_name: ""}
    assert_template 'paymethods/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    xhr :get, new_paymethod_path
    assert_template 'paymethods/new'
    paymethod_name = "てすと"
    xhr :post, paymethods_path, paymethod: { paymethod_name: paymethod_name}
    assert_not flash.empty?
    assert_template 'paymethods/create'
    assert_not_nil assigns(:paymethods)
  end
end
