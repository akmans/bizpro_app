#encoding: utf-8
require 'test_helper'

class CustomsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "unsuccessful create" do
    log_in_as(@user)
    get new_custom_path
    assert_template 'customs/new'
    post customs_path, custom: { #custom_id:  "",
                                custom_name: "",
                                is_auction: 0,
                                net_cost: 1,
                                tax_cost: 10,
                                other_cost: 100,
                                memo: "あいうえお"
    }
    assert_template 'customs/new'
  end
  
  test "successful create" do
    log_in_as(@user)
    get new_custom_path
    assert_template 'customs/new'
    custom_name = "てすと"
    post customs_path, custom: { #custom_id:  "",
                                custom_name: "カスタム名称",
                                is_auction: 0,
                                net_cost: 1,
                                tax_cost: 10,
                                other_cost: 100,
                                memo: "あいうえお"
    }
    assert_not flash.empty?
    assert_redirected_to customs_path
  end
end
