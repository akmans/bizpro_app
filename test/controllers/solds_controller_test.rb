require 'test_helper'

class SoldsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @product = products(:one)
    @sold = solds(:one)
  end

  # test routes
  test "should route to index" do
    assert_routing "/products/#{@product.product_id}/solds",
                   { controller: "solds", action: "index", product_product_id: "#{@product.product_id}" }
  end

  test "should route to new" do
    assert_routing "/products/#{@product.product_id}/solds/new",
                   { controller: "solds", action: "new", product_product_id: "#{@product.product_id}" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: "/products/#{@product.product_id}/solds", product_product_id: "#{@product.product_id}" },
                   { controller: "solds", action: "create", product_product_id: "#{@product.product_id}" })
  end

  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}/solds/#{@sold.id}" },
                   { controller: "solds", action: "destroy", product_product_id: "#{@product.product_id}", id: "#{@sold.id}" })
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index, :product_product_id => @product.product_id
    assert_response :success
    assert_select 'title', full_title_help('一覧,売上情報,商品')
    assert_not_nil assigns(:solds)
  end
  
  test "should redirect index when not logged in" do
    get :index, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test action new
  test "should get new when logged in" do
    log_in_as(@user)
    xhr :get, :new, :product_product_id => @product.product_id
    assert_response :success
    assert_not_nil assigns(:sold)
  end
  
  test "should redirect new when not logged in" do
    xhr :get, :new, :product_product_id => @product.product_id
    assert_redirected_to login_url
  end

  # test action create
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
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    xhr :get, :edit, :product_product_id => @product.product_id, :id => @sold.id
    assert_response :success
    assert_not_nil assigns(:sold)
  end
  
  test "should redirect edit when not logged in" do
    xhr :get, :edit, :product_product_id => @product.product_id, :id => @sold.id
    assert_redirected_to login_url
  end

  # test action update
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
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy sold when logged in" do
    log_in_as(@user)
    assert_difference 'Sold.count', -1 do
      xhr :delete, :destroy, product_product_id: @product, id: @sold
    end
    assert_not flash.empty?
    assert_not_nil assigns(:solds)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Sold.count' do
      xhr :delete, :destroy, product_product_id: @product, id: @sold
    end
    assert_redirected_to login_url
  end
end
