#encoding: utf-8
require 'test_helper'

class CustomsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @custom = customs(:two)
  end

  # test routes
  test "should route to index" do
    assert_routing "/customs",
                   { controller: "customs", action: "index" }
  end
 
  test "should route to show" do
    assert_routing "/customs/#{@custom.custom_id}",
                   { controller: "customs", action: "show", custom_id: "#{@custom.custom_id}" }
  end
 
  test "should route to new" do
    assert_routing "/customs/new",
                   { controller: "customs", action: "new" }
  end
 
  test "should route to create" do
    assert_routing({ method: 'post', path: '/customs' },
                   { controller: "customs", action: "create" })
  end
 
  test "should route to edit" do
    assert_routing "/customs/#{@custom.custom_id}/edit",
                   { controller: "customs", action: "edit", custom_id: "#{@custom.custom_id}" }
  end
 
  test "should route to update" do
    assert_routing({ method: 'patch', path: "/customs/#{@custom.custom_id}" },
                   { controller: "customs", action: "update", custom_id: "#{@custom.custom_id}" })
  end
 
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: "/customs/#{@custom.custom_id}" },
                   { controller: "customs", action: "destroy", custom_id: "#{@custom.custom_id}" })
  end
 
  test "should route to ajax_auction_percentage" do
    assert_routing "/ajax/auction_percentage",
                   { controller: "customs", action: "ajax_auction_percentage" }
  end

  # test action index
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_select 'title', full_title('一覧,カスタム')
    assert_not_nil assigns(:customs)
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
    assert_select 'title', full_title('新規,カスタム')
    assert_not_nil assigns(:custom)
  end
 
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  # test action create
  test "should create custom when logged in" do
    log_in_as(@user)
    assert_difference 'Custom.count', 1 do
      post :create, custom: { custom_name: "Custom Name",
                              is_auction: 0}
    end
    assert_redirected_to customs_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Custom.count' do
      post :create, custom: { custom_name: "Custom Name",
                              is_auction: 0}
    end
    assert_redirected_to login_url
  end

  # test action edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get :edit, custom_id: @custom
    assert_response :success
    assert_select 'title', full_title('編集,カスタム')
    assert_not_nil assigns(:custom)
  end

  test "should redirect edit when not logged in" do
    get :edit, custom_id: @custom
    assert_not flash.empty?
    assert_redirected_to login_url
  end
 
  # test action update
  test "should update custom when logged in" do
    log_in_as(@user)
    custom_name = "てすと"
    is_auction = 1
    auction_id = "fdaeafeafx"
    percentage = 30
    net_cost = 90
    tax_cost = 900
    other_cost = 9000
    memo = 'メモメモメモ'
    patch :update, custom_id: @custom, \
          custom: { custom_name: custom_name,
                     is_auction: is_auction,
                     auction_id: auction_id,
                     percentage: percentage,
                     net_cost: net_cost,
                     tax_cost: tax_cost,
                     other_cost: other_cost,
                     memo: memo
          }
    @custom.reload
    assert_equal @custom.custom_name, custom_name
    assert_equal @custom.is_auction, is_auction
    assert_equal @custom.auction_id, auction_id
    assert_equal @custom.percentage, percentage
    assert_equal @custom.net_cost, net_cost
    assert_equal @custom.tax_cost, tax_cost
    assert_equal @custom.other_cost, other_cost
    assert_equal @custom.memo, memo
    assert_redirected_to customs_path
  end

  test "should redirect update when not logged in" do
    custom_name = "てすと"
    is_auction = 1
    auction_id = "fdaeafeafx"
    percentage = 30
    net_cost = 90
    tax_cost = 900
    other_cost = 9000
    memo = 'メモメモメモ'
    patch :update, custom_id: @custom, \
          custom: {custom_name: custom_name,
                   is_auction: is_auction,
                   auction_id: auction_id,
                   percentage: percentage,
                   net_cost: net_cost,
                   tax_cost: tax_cost,
                   other_cost: other_cost,
                   memo: memo
          }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test action destory
  test "should destroy custom when logged in" do
    log_in_as(@user)
    assert_difference 'Custom.count', -1 do
      delete :destroy, custom_id: @custom
    end
    assert_redirected_to customs_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Custom.count' do
      delete :destroy, custom_id: @custom
    end
    assert_redirected_to login_url
  end
end