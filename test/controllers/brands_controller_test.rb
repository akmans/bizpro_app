# encoding: utf-8
require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  def setup
    @brand = brands(:one)
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', "新規 | ブランド | オーディオPRO"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "一覧 | ブランド | オーディオPRO"
  end

  test "should get edit" do
    get :edit, brand_id: @brand
    assert_response :success
    assert_select 'title', "編集 | ブランド | オーディオPRO"
  end

end
