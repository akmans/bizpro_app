#encoding: utf-8
require 'test_helper'

class AuctionsAjaxTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @auction = auctions(:one)
  end
  
  test "should get auction data as json format" do
    log_in_as(@user)
    expected = {'' => '(空白)', 'One1' => 'OneOneOneOneOne 11111'}
    get '/ajax/auctions', ope_flg: 0
    assert_equal expected.to_json, response.body
  end
end
