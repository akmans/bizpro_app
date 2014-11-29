# encoding: utf-8
require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  def setup
    @brand = brands(:one)
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', full_title('新規,ブランド,マスタ管理')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,ブランド,マスタ管理')
  end

  test "should get edit" do
    get :edit, brand_id: @brand
    assert_response :success
    assert_select 'title', full_title('編集,ブランド,マスタ管理')
  end

end
