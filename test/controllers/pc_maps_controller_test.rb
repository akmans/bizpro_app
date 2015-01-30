#encoding: utf-8
require 'test_helper'

class PcMapsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @pc_map = pc_maps(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :product_product_id => @product.product_id
    assert_response :success
    assert_select 'title', full_title_help('カスタムリスト,商品')
    assert_not_nil assigns(:pc_maps)
    assert_template 'pc_maps/index'
    assert_select 'a[href=?]', new_product_pc_map_path, remote: true, text: 'New'
    PcMap.where(product_id: @product_id).each do |pc_map|
      assert_select 'a[href=?]', product_pc_map_path(pc_map.custom_id), text: 'Del', remote: true, method: :delete
    end
  end

  test "should redirect index when not logged in" do
    get :index, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test show action
  # nil

  # test new action
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new, :product_product_id => @product.product_id
    assert_response :success
    assert_not_nil assigns(:pc_map)
  end

  test "get new should show message when not logged in" do
    xhr :get, :new, :product_product_id => @product.product_id
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create pc_map when logged in" do
    log_in_as(@user)
    assert_difference 'PcMap.count', 1 do
      xhr :post, :create, product_product_id: @product.product_id, pc_map: { custom_id: "Two2" }
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pc_maps)
    assert_equal '作成完了しました。', flash[:success]
  end

  test "post create should show message when not logged in" do
    assert_no_difference 'PcMap.count' do
      xhr :post, :create, product_product_id: @product.product_id, modu: { custom_id: "Two2" }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  # nil

  # test update action
  # nil

  # test destory action
  test "should destroy pc_map when logged in" do
    log_in_as(@user)
    assert_difference 'PcMap.count', -1 do
      xhr :delete, :destroy, product_product_id: @product, custom_id: @pc_map
    end
    assert_not flash.empty?
    assert_not_nil assigns(:pc_maps)
    assert_equal '削除完了しました。', flash[:success]
  end

  test "delete destroy should show message when not logged in" do
    assert_no_difference 'PcMap.count' do
      xhr :delete, :destroy, product_product_id: @product, custom_id: @pc_map
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end
