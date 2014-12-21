#encoding: utf-8
require 'test_helper'

class CustomsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @custom = customs(:two)
  end
  
  test "show including index links" do
    log_in_as(@user)
    get custom_path(@custom)
    assert_template 'customs/show'
    assert_select 'a[href=?]', customs_path, text: '戻る'
  end
end
