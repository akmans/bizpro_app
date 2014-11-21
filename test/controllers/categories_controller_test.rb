# encoding: utf-8

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "一覧 | カテゴリー | オーディオPRO"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', "新規 | カテゴリー | オーディオPRO"
  end

end
