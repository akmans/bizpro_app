# encoding: utf-8
require 'test_helper'

class PaymethodsControllerTest < ActionController::TestCase
  def setup
    @paymethod = categories(:one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "一覧 | 支払い方法 | マスタ管理 | オーディオPRO"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', "新規 | 支払い方法 | マスタ管理 | オーディオPRO"
  end

  test "should get edit" do
    get :edit, paymethod_id: @paymethod
    assert_response :success
    assert_select 'title', "編集 | 支払い方法 | マスタ管理 | オーディオPRO"
  end
end
