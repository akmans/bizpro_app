require 'test_helper'

class SoldsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @sold = solds(:one)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :product_product_id => @product.product_id
    assert_response :success
    assert_select 'title', full_title_help('一覧,売上情報,商品')
    assert_not_nil assigns(:solds)
    assert_template 'solds/index'
    assert_select 'a[href=?]', new_product_sold_path, text: 'New'
    Sold.where(product_id: @product.product_id).all.each do |sold|
      assert_select 'a[href=?]', edit_product_sold_path(id: sold.id), text: 'Edi', remote: true
      assert_select 'a[href=?]', product_sold_path(id: sold.id), text: 'Del', remote: true, method: :delete
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
    assert_not_nil assigns(:sold)
  end

  test "should redirect new when not logged in" do
    xhr :get, :new, :product_product_id => @product.product_id
    assert_equal 'Please log in.', flash[:danger]
  end

  # test create action
  test "should create sold when logged in" do
    log_in_as(@user)
    sold_date = Time.zone.now
    sold_price = 100
    ship_charge = 200
    other_charge = 300
    memo = "test memo"
    assert_difference 'Sold.count', 1 do
      xhr :post, :create, product_product_id: @product.product_id,
        sold: { sold_date: sold_date, sold_price: sold_price,
                ship_charge: ship_charge, other_charge: other_charge, memo: memo }
    end
    assert_not flash.empty?
    assert_not_nil assigns(:solds)
    assert_equal '作成完了しました。', flash[:success]
  end

  test "should redirect create when not logged in" do
    sold_date = Time.zone.now
    sold_price = 100
    ship_charge = 200
    other_charge = 300
    memo = "test memo"
    assert_no_difference 'Sold.count' do
      xhr :post, :create, product_product_id: @product.product_id,
        sold: { sold_date: sold_date, sold_price: sold_price,
                ship_charge: ship_charge, other_charge: other_charge, memo: memo }
    end
    assert_equal 'Please log in.', flash[:danger]
  end

  # test edit action
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, :product_product_id => @product.product_id, :id => @sold.id
    assert_response :success
    assert_not_nil assigns(:sold)
  end

  test "should redirect edit when not logged in" do
    xhr :get, :edit, :product_product_id => @product.product_id, :id => @sold.id
    assert_equal 'Please log in.', flash[:danger]
  end

  # test update action
  test "should update sold when logged in" do
    log_in_as(@user)
    sold_date = Date.today
    sold_price = 100
    ship_charge = 200
    other_charge = 300
    memo = "test memo"
    xhr :post, :update, product_product_id: @product.product_id, id: @sold,
        sold: { sold_date: sold_date, sold_price: sold_price,
                ship_charge: ship_charge, other_charge: other_charge, memo: memo }
    assert_not flash.empty?
    @sold.reload
    assert_equal sold_date, @sold.sold_date
    assert_equal sold_price, @sold.sold_price
    assert_equal ship_charge, @sold.ship_charge
    assert_equal other_charge, @sold.other_charge
    assert_equal memo, @sold.memo
    assert_not_nil assigns(:solds)
    assert_equal '更新完了しました。', flash[:success]
  end

  test "should redirect update when not logged in" do
    sold_date = Date.today
    sold_price = 100
    ship_charge = 200
    other_charge = 300
    memo = "test memo"
    xhr :post, :update, product_product_id: @product.product_id, id: @sold,
        sold: { sold_date: sold_date, sold_price: sold_price,
                ship_charge: ship_charge, other_charge: other_charge, memo: memo }
    assert_equal 'Please log in.', flash[:danger]
  end

  # test destory action
  test "should destroy sold when logged in" do
    log_in_as(@user)
    assert_difference 'Sold.count', -1 do
      xhr :delete, :destroy, product_product_id: @product, id: @sold
    end
    assert_not flash.empty?
    assert_not_nil assigns(:solds)
    assert_equal '削除完了しました。', flash[:success]
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Sold.count' do
      xhr :delete, :destroy, product_product_id: @product, id: @sold
    end
    assert_equal 'Please log in.', flash[:danger]
  end
end
