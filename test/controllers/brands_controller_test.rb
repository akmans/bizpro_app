# encoding: utf-8
require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help('一覧,ブランド,マスタ管理')
    assert_not_nil assigns(:brands)
    assert_template 'brands/index'
    assert_select 'div.pagination'
    assert_select 'a[href=?]', new_brand_path, text: 'New'
    Brand.paginate(page: 1, per_page: 15).each do |brand|
      assert_select 'a[href=?]', edit_brand_path(brand.brand_id), text: 'Edi'
      assert_select 'a[href=?]', brand_path(brand.brand_id), text: 'Del', method: :delete
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
    assert_not_nil assigns(:brand)
  end

  test "get new should show message when not logged in" do
    xhr :get, :new
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create brand when logged in" do
    log_in_as(@user)
    brand_name = "Brand Name"
    assert_difference 'Brand.count', 1 do
      xhr :post, :create, brand: { brand_name: brand_name}
    end
    assert_equal '作成完了しました。', flash[:success]
    assert_not_nil assigns(:brands)
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'Brand.count' do
      xhr :post, :create, brand: { brand_name: "Brand Name" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, brand_id: @brand
    assert_response :success
    assert_not_nil assigns(:brand)
  end

  test "get edit should show message when not logged in" do
    xhr :get, :edit, brand_id: @brand
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update brand when logged in" do
    log_in_as(@user)
    brand_name = "てすと"
    xhr :patch, :update, brand_id: @brand, brand: { brand_name: brand_name }
    @brand.reload
    assert_equal @brand.brand_name, brand_name
    assert_equal '更新完了しました。', flash[:success]
    assert_not_nil assigns(:brands)
  end

  test "patch update should show message when not logged in" do
    brand_name = "てすと"
    xhr :patch, :update, brand_id: @brand, brand: { brand_name: brand_name }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy brand when logged in" do
    log_in_as(@user)
    assert_difference 'Brand.count', -1 do
      xhr :delete, :destroy, brand_id: @brand
    end
    assert_equal '削除完了しました。', flash[:success]
    assert_not_nil assigns(:brands)
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'Brand.count' do
      xhr :delete, :destroy, brand_id: @brand
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end