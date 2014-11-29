# encoding: utf-8
require 'test_helper'

class ShipmethodsControllerTest < ActionController::TestCase
  def setup
    @shipmethod = shipmethods(:one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', full_title("一覧,発送方法,マスタ管理")
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', full_title("新規,発送方法,マスタ管理")
  end

  test "should get edit" do
    get :edit, shipmethod_id: @shipmethod
    assert_response :success
    assert_select 'title', full_title("編集,発送方法,マスタ管理")
  end
end
