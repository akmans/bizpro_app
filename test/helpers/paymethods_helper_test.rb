# encoding: utf-8
require 'test_helper'

class PaymethodsHelperTest < ActionView::TestCase
  def setup
    @paymethod = paymethods(:one)
  end

  # test paymethod_name_help
  test "test paymethod name help" do
    assert_equal "-", paymethod_name_help(nil)
    assert_equal "-", paymethod_name_help("    ")
    assert_equal @paymethod.paymethod_name, paymethod_name_help(@paymethod.paymethod_id)
  end

  # test paymethod_hash_help
  test "test paymethod hash help" do
    assert_not_nil paymethod_hash_help
  end
end