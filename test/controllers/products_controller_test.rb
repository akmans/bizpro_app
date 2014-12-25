#encoding: utf-8
require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,商品')
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
    assert_select 'title', full_title('新規,商品')
  end
 
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create product when logged in" do
    log_in_as(@user)
    assert_difference 'Product.count', 1 do
      post :create, product: { product_name: "Product Name",
                               is_domestic: 0}
    end
    assert_redirected_to products_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Product.count' do
      post :create, product: { product_name: "Product Name",
                               is_domestic: 0}
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, product_id: @product
    assert_response :success
    assert_select 'title', full_title('編集,商品')
  end

  test "should redirect edit when not logged in" do
    get :edit, product_id: @product
    assert_not flash.empty?
    assert_redirected_to login_url
  end
 
  # test action update
  test "should update product when logged in" do
    log_in_as(@user)
    product_name = "てすと"
    is_domestic = 1
    exchange_rate = 9.9
    category_id = "c1"
    brand_id = "b1"
    modu_id = "m1"
    memo = 'メモメモメモ'
    patch :update, product_id: @product, \
          product: { product_name: product_name,
                     is_domestic: is_domestic,
                     exchange_rate: exchange_rate,
                     category_id: category_id,
                     brand_id: brand_id,
                     modu_id: modu_id,
                     memo: memo
          }
    @product.reload
    assert_equal @product.product_name, product_name
    assert_equal @product.is_domestic, is_domestic
    assert_equal @product.exchange_rate.to_f, exchange_rate
    assert_equal @product.category_id, category_id
    assert_equal @product.brand_id, brand_id
    assert_equal @product.modu_id, modu_id
    assert_equal @product.memo, memo
    assert_redirected_to products_path
  end

  test "should redirect update when not logged in" do
    product_name = "てすと"
    is_domestic = 1
    exchange_rate = 9.9
    category_id = "c1"
    brand_id = "b1"
    modu_id = "m1"
    memo = 'メモメモメモ'
    patch :update, product_id: @product, \
          product: { product_name: product_name,
                     is_domestic: is_domestic,
                     exchange_rate: exchange_rate,
                     category_id: category_id,
                     brand_id: brand_id,
                     modu_id: modu_id,
                     memo: memo
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy product when logged in" do
    log_in_as(@user)
    assert_difference 'Product.count', -1 do
      delete :destroy, product_id: @product
    end
    assert_redirected_to products_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Product.count' do
      delete :destroy, product_id: @product
    end
    assert_redirected_to login_url
  end

end
