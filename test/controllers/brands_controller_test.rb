# encoding: utf-8
require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @brand = brands(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/brands",
                   { controller: "brands", action: "index" }
  end
 
#  test "should route to show" do
#    assert_routing "/brands/#{@brand.brand_id}",
#                   { controller: "brands", action: "show", brand_id: "#{@brand.brand_id}" }
#  end
 
  test "should route to new" do
    assert_routing "/brands/new",
                   { controller: "brands", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/brands' },
                   { controller: "brands", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/brands/#{@brand.brand_id}/edit",
                   { controller: "brands", action: "edit", brand_id: "#{@brand.brand_id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/brands/#{@brand.brand_id}" },
                   { controller: "brands", action: "update", brand_id: "#{@brand.brand_id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/brands/#{@brand.brand_id}" },
                   { controller: "brands", action: "destroy", brand_id: "#{@brand.brand_id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title_help('一覧,ブランド,マスタ管理')
    assert_not_nil assigns(:brands)
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
    assert_select 'title', full_title_help('新規,ブランド,マスタ管理')
    assert_not_nil assigns(:brand)
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create brand when logged in" do
    log_in_as(@user)
    brand_name = "Brand Name"
    assert_difference 'Brand.count', 1 do
      post :create, brand: { brand_name: brand_name}
    end
    assert_redirected_to brands_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Brand.count' do
      post :create, brand: { brand_name: "Brand Name" }
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, brand_id: @brand
    assert_response :success
    assert_select 'title', full_title_help('編集,ブランド,マスタ管理')
    assert_not_nil assigns(:brand)
  end

  test "should redirect edit when not logged in" do
    get :edit, brand_id: @brand
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action update
  test "should update brand when logged in" do
    log_in_as(@user)
    brand_name = "てすと"
    patch :update, brand_id: @brand, brand: { brand_name: brand_name }
    @brand.reload
    assert_equal @brand.brand_name, brand_name
    assert_redirected_to brands_path
  end

  test "should redirect update when not logged in" do
    brand_name = "てすと"
    patch :update, brand_id: @brand, brand: { brand_name: brand_name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy brand when logged in" do
    log_in_as(@user)
    assert_difference 'Brand.count', -1 do
      delete :destroy, brand_id: @brand
    end
    assert_redirected_to brands_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Brand.count' do
      delete :destroy, brand_id: @brand
    end
    assert_redirected_to login_url
  end
end