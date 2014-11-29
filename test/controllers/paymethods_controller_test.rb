# encoding: utf-8
require 'test_helper'

class PaymethodsControllerTest < ActionController::TestCase
  def setup
    @paymethod = paymethods(:one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', full_title("一覧,支払い方法,マスタ管理")
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', full_title("新規,支払い方法,マスタ管理")
  end

  test "should get edit" do
    get :edit, paymethod_id: @paymethod
    assert_response :success
    assert_select 'title', full_title("編集,支払い方法,マスタ管理")
  end
end
