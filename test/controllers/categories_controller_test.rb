# encoding: utf-8

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = categories(:one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "一覧 | カテゴリー | マスタ管理 | オーディオPRO"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', "新規 | カテゴリー | マスタ管理 | オーディオPRO"
  end

  test "should get edit" do
    get :edit, category_id: @category
    assert_response :success
    assert_select 'title', "編集 | カテゴリー | マスタ管理 | オーディオPRO"
  end
end
