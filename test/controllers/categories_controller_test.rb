# encoding: utf-8

require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @category = categories(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help('一覧,カテゴリー,マスタ管理')
    assert_not_nil assigns(:categories)
    assert_template 'categories/index'
    assert_select 'a[href=?]', new_category_path, remote: true, text: 'New'
    Category.paginate(page: 1, :per_page => 15).each do |category|
      assert_select 'a[href=?]', edit_category_path(category.category_id), remote: true, text: 'Edi'
      assert_select 'a[href=?]', category_path(category.category_id), \
                    remote: true, text: 'Del', method: :delete
    end
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test show action
  # nil

  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:category)
  end

  test "get new should show message when not logged in" do
    xhr :get, :new
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create category when logged in" do
    log_in_as(@user)
    assert_difference 'Category.count', 1 do
      xhr :post, :create, category: { category_name: "Category Name" }
    end
    assert_equal '作成完了しました。', flash[:success]
    assert_not_nil assigns(:categories)
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'Category.count' do
      xhr :post, :create, category: { category_name: "Category Name" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, category_id: @category
    assert_response :success
    assert_not_nil assigns(:category)
  end

  test "get edit should show message when not logged in" do
    xhr :get, :edit, category_id: @category
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update category when logged in" do
    log_in_as(@user)
    category_name = "てすと"
    xhr :patch, :update, category_id: @category, category: { category_name: category_name }
    @category.reload
    assert_equal @category.category_name, category_name
    assert_equal '更新完了しました。', flash[:success]
    assert_not_nil assigns(:categories)
  end

  test "patch update should show message when not logged in" do
    category_name = "てすと"
    xhr :patch, :update, category_id: @category, category: { category_name: category_name }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy category when logged in" do
    log_in_as(@user)
    assert_difference 'Category.count', -1 do
      xhr :delete, :destroy, category_id: @category
    end
    assert_equal '削除完了しました。', flash[:success]
    assert_not_nil assigns(:categories)
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'Category.count' do
      xhr :delete, :destroy, category_id: @category
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end