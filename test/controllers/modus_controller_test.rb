# encoding: utf-8
require 'test_helper'

class ModusControllerTest < ActionController::TestCase
  def setup
    @brand = brands(:one)
    @modu = modus(:one)
  end
  
  test "should get new" do
    get :new, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_select 'title', full_title('新規,モデル,マスタ管理')
  end

  test "should get index" do
    get :index, :brand_brand_id => @brand.brand_id
    assert_response :success
    assert_select 'title', full_title('一覧,モデル,マスタ管理')
  end

  test "should get edit" do
    get :edit, :brand_brand_id => @brand.brand_id, modu_id: @modu
    assert_response :success
    assert_select 'title', full_title('編集,モデル,マスタ管理')
  end

end
