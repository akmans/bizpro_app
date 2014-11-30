# encoding: utf-8

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @category = categories(:one)
  end
  
  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,カテゴリー,マスタ管理')
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
    assert_select 'title', full_title('新規,カテゴリー,マスタ管理')
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create category when logged in" do
    log_in_as(@user)
    assert_difference 'Category.count', 1 do
      post :create, category: { category_name: "Category Name" }
    end
    assert_redirected_to categories_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: { category_name: "Category Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, category_id: @category
    assert_response :success
    assert_select 'title', full_title('編集,カテゴリー,マスタ管理')
  end

  test "should redirect edit when not logged in" do
    get :edit, category_id: @category
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update category when logged in" do
    log_in_as(@user)
    category_name = "てすと"
    patch :update, category_id: @category, category: { category_name: category_name }
    @category.reload
    assert_equal @category.category_name, category_name
    assert_redirected_to categories_path
  end

  test "should redirect update when not logged in" do
    category_name = "てすと"
    patch :update, category_id: @category, category: { category_name: category_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy category when logged in" do
    log_in_as(@user)
    assert_difference 'Category.count', -1 do
      delete :destroy, category_id: @category
    end
    assert_redirected_to categories_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Category.count' do
      delete :destroy, category_id: @category
    end
    assert_redirected_to login_url
  end
end
