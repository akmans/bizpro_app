#encoding: utf-8
require 'test_helper'

class RoutesTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @auction = auctions(:one)
    @brand = brands(:one)
    @category = categories(:one)
    @custom = customs(:one)
    @modu = modus(:one)
    @product = products(:one)
    @pa_map = pa_maps(:one)
    @paymethod = paymethods(:one)
    @pc_map = pc_maps(:one)
    @shipment = shipments(:one)
    @shipment_detail = shipment_details(:one)
    @shipmethod = shipmethods(:one)
    @sold = solds(:one)
  end

  def teardown
  end

  # ---------- test resources auctions ---------------------------------
  # test route to auctions#index
  test "should route to auctions#index" do
    assert_routing "/auctions",
                   { controller: "auctions", action: "index" }
  end

  # test route to auctions#show
  test "should route to auctions#show" do
    assert_routing "/auctions/#{@auction.auction_id}",
                   { controller: "auctions", action: "show", auction_id: "#{@auction.auction_id}" }
  end

  # test route to auctions#new
  test "should route to auctions#new" do
    assert_routing "/auctions/new",
                   { controller: "auctions", action: "new" }
  end

  # test route to auctions#create
  test "should route to auctions#create" do
    assert_routing({ method: 'post', path: '/auctions' },
                   { controller: "auctions", action: "create" })
  end

  # test route to auctions#edit
  test "should route to auctions#edit" do
    assert_routing "/auctions/#{@auction.auction_id}/edit",
                   { controller: "auctions", action: "edit", auction_id: "#{@auction.auction_id}" }
  end

  # test route to auctions#update
  test "should route to auctions#update" do
    assert_routing({ method: 'patch', path: "/auctions/#{@auction.auction_id}" },
                   { controller: "auctions", action: "update", auction_id: "#{@auction.auction_id}" })
  end

  # test route to auctions#destroy
  test "should route to auctions#destroy" do
    assert_routing({ method: 'delete', path: "/auctions/#{@auction.auction_id}" },
                   { controller: "auctions", action: "destroy", auction_id: "#{@auction.auction_id}" })
  end

  # ---------- test resources brands ---------------------------------
  # test route to brands#index
  test "should route to brands#index" do
    assert_routing "/brands",
                   { controller: "brands", action: "index" }
  end
 
  # test route to brands#show
  # nil

  # test route to brands#new
  test "should route to brands#new" do
    assert_routing "/brands/new",
                   { controller: "brands", action: "new" }
  end

  # test route to brands#create
  test "should route to brands#create" do
    assert_routing({ method: 'post', path: '/brands' },
                   { controller: "brands", action: "create" })
  end

  # test route to brands#edit
  test "should route to brands#edit" do
    assert_routing "/brands/#{@brand.brand_id}/edit",
                   { controller: "brands", action: "edit", brand_id: "#{@brand.brand_id}" }
  end

  # test route to brands#update
  test "should route to brands#update" do
    assert_routing({ method: 'patch', path: "/brands/#{@brand.brand_id}" },
                   { controller: "brands", action: "update", brand_id: "#{@brand.brand_id}" })
  end

  # test route to brands#destroy
  test "should route to brands#destroy" do
    assert_routing({ method: 'delete', path: "/brands/#{@brand.brand_id}" },
                   { controller: "brands", action: "destroy", brand_id: "#{@brand.brand_id}" })
  end

  # ---------- test resources modus ---------------------------------
  # test route to modus#index
  test "should route to modus#index" do
    assert_routing "/brands/#{@brand.brand_id}/modus",
                   { controller: "modus", action: "index", brand_brand_id: "#{@brand.brand_id}" }
  end

  # test route to modus#show
  # nil

  # test route to modus#new
  test "should route to modus#new" do
    assert_routing "/brands/#{@brand.brand_id}/modus/new",
                   { controller: "modus", action: "new", brand_brand_id: "#{@brand.brand_id}" }
  end

  # test route to modus#create
  test "should route to modus#create" do
    assert_routing({ method: 'post', path: "/brands/#{@brand.brand_id}/modus", brand_brand_id: "#{@brand.brand_id}" },
                   { controller: "modus", action: "create", brand_brand_id: "#{@brand.brand_id}" })
  end

  # test route to modus#edit
  test "should route to modus#edit" do
    assert_routing "/brands/#{@brand.brand_id}/modus/#{@modu.modu_id}/edit",
                   { controller: "modus", action: "edit", brand_brand_id: "#{@brand.brand_id}", modu_id: "#{@modu.modu_id}" }
  end

  # test route to modus#update
  test "should route to modus#update" do
    assert_routing({ method: 'patch', path: "/brands/#{@brand.brand_id}/modus/#{@modu.modu_id}" },
                   { controller: "modus", action: "update", brand_brand_id: "#{@brand.brand_id}", modu_id: "#{@modu.modu_id}" })
  end

  # test route to modus#destroy
  test "should route to modus#destroy" do
    assert_routing({ method: 'delete', path: "/brands/#{@brand.brand_id}/modus/#{@modu.modu_id}" },
                   { controller: "modus", action: "destroy", brand_brand_id: "#{@brand.brand_id}", modu_id: "#{@modu.modu_id}" })
  end

  # ---------- test resources categories ---------------------------------
  # test routes
  test "should route to categories#index" do
    assert_routing "/categories",
                   { controller: "categories", action: "index" }
  end

  # test route to categories#show
  # nil

  # test route to categories#new
  test "should route to categories#new" do
    assert_routing "/categories/new",
                   { controller: "categories", action: "new" }
  end

  # test route to categories#create
  test "should route to categories#create" do
    assert_routing({ method: 'post', path: '/categories' },
                   { controller: "categories", action: "create" })
  end

  # test route to categories#edit
  test "should route to categories#edit" do
    assert_routing "/categories/#{@category.category_id}/edit",
                   { controller: "categories", action: "edit", category_id: "#{@category.category_id}" }
  end

  # test route to categories#update
  test "should route to categories#update" do
    assert_routing({ method: 'patch', path: "/categories/#{@category.category_id}" },
                   { controller: "categories", action: "update", category_id: "#{@category.category_id}" })
  end

  # test route to categories#destroy
  test "should route to categories#destroy" do
    assert_routing({ method: 'delete', path: "/categories/#{@category.category_id}" },
                   { controller: "categories", action: "destroy", category_id: "#{@category.category_id}" })
  end

  # ---------- test resources customs ---------------------------------
  # test route to customs#index
  test "should route to customs#index" do
    assert_routing "/customs",
                   { controller: "customs", action: "index" }
  end

  # test route to customs#show
  test "should route to customs#show" do
    assert_routing "/customs/#{@custom.custom_id}",
                   { controller: "customs", action: "show", custom_id: "#{@custom.custom_id}" }
  end

  # test route to customs#new
  test "should route to customs#new" do
    assert_routing "/customs/new",
                   { controller: "customs", action: "new" }
  end

  # test route to customs#create
  test "should route to customs#create" do
    assert_routing({ method: 'post', path: '/customs' },
                   { controller: "customs", action: "create" })
  end

  # test route to customs#edit
  test "should route to customs#edit" do
    assert_routing "/customs/#{@custom.custom_id}/edit",
                   { controller: "customs", action: "edit", custom_id: "#{@custom.custom_id}" }
  end

  # test route to customs#update
  test "should route to customs#update" do
    assert_routing({ method: 'patch', path: "/customs/#{@custom.custom_id}" },
                   { controller: "customs", action: "update", custom_id: "#{@custom.custom_id}" })
  end

  # test route to customs#destroy
  test "should route to customs#destroy" do
    assert_routing({ method: 'delete', path: "/customs/#{@custom.custom_id}" },
                   { controller: "customs", action: "destroy", custom_id: "#{@custom.custom_id}" })
  end

  # ---------- test resources paymethods ---------------------------------
  # test route to paymethods#index
  test "should route to paymethods#index" do
    assert_routing "/paymethods",
                   { controller: "paymethods", action: "index" }
  end

  # test route to paymethods#show
  # nil

  # test route to paymethods#new
  test "should route to paymethods#new" do
    assert_routing "/paymethods/new",
                   { controller: "paymethods", action: "new" }
  end

  # test route to paymethods#create
  test "should route to paymethods#create" do
    assert_routing({ method: 'post', path: '/paymethods' },
                   { controller: "paymethods", action: "create" })
  end

  # test route to paymethods#edit
  test "should route to paymethods#edit" do
    assert_routing "/paymethods/#{@paymethod.paymethod_id}/edit",
                   { controller: "paymethods", action: "edit", paymethod_id: "#{@paymethod.paymethod_id}" }
  end

  # test route to paymethods#update
  test "should route to paymethods#update" do
    assert_routing({ method: 'patch', path: "/paymethods/#{@paymethod.paymethod_id}" },
                   { controller: "paymethods", action: "update", paymethod_id: "#{@paymethod.paymethod_id}" })
  end

  # test route to paymethods#destroy
  test "should route to paymethods#destroy" do
    assert_routing({ method: 'delete', path: "/paymethods/#{@paymethod.paymethod_id}" },
                   { controller: "paymethods", action: "destroy", paymethod_id: "#{@paymethod.paymethod_id}" })
  end

  # ---------- test resources products ---------------------------------
  # test route to products#index
  test "should route to products#index" do
    assert_routing "/products",
                   { controller: "products", action: "index" }
  end

  # test route to products#show
  test "should route to products#show" do
    assert_routing "/products/#{@product.product_id}",
                   { controller: "products", action: "show", product_id: "#{@product.product_id}" }
  end

  # test route to products#new
  test "should route to products#new" do
    assert_routing "/products/new",
                   { controller: "products", action: "new" }
  end

  # test route to products#create
  test "should route to products#create" do
    assert_routing({ method: 'post', path: '/products' },
                   { controller: "products", action: "create" })
  end

  # test route to products#edit
  test "should route to products#edit" do
    assert_routing "/products/#{@product.product_id}/edit",
                   { controller: "products", action: "edit", product_id: "#{@product.product_id}" }
  end

  # test route to products#update
  test "should route to products#update" do
    assert_routing({ method: 'patch', path: "/products/#{@product.product_id}" },
                   { controller: "products", action: "update", product_id: "#{@product.product_id}" })
  end

  # test route to products#destroy
  test "should route to products#destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}" },
                   { controller: "products", action: "destroy", product_id: "#{@product.product_id}" })
  end

  # ---------- test resources pa_maps ---------------------------------
  # test route to pa_maps#index
  test "should route to pa_maps#index" do
    assert_routing "/products/#{@product.product_id}/pa_maps",
                   { controller: "pa_maps", action: "index", product_product_id: "#{@product.product_id}" }
  end

  # test route to pa_maps#show
  # nil

  # test route to pa_maps#new
  test "should route to pa_maps#new" do
    assert_routing "/products/#{@product.product_id}/pa_maps/new",
                   { controller: "pa_maps", action: "new", product_product_id: "#{@product.product_id}" }
  end
 
  # test route to pa_maps#create
  test "should route to pa_maps#create" do
    assert_routing({ method: 'post', path: "/products/#{@product.product_id}/pa_maps", product_product_id: "#{@product.product_id}" },
                   { controller: "pa_maps", action: "create", product_product_id: "#{@product.product_id}" })
  end

  # test route to pa_maps#edit
  # nil

  # test route to pa_maps#update
  # nil

  # test route to pa_maps#destroy
  test "should route to pa_maps#destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}/pa_maps/#{@pa_map.auction_id}" },
                   { controller: "pa_maps", action: "destroy", product_product_id: "#{@product.product_id}", auction_id: "#{@pa_map.auction_id}" })
  end

  # ---------- test resources pc_maps ---------------------------------
  # test route to pc_maps#index
  test "should route to pc_maps#index" do
    assert_routing "/products/#{@product.product_id}/pc_maps",
                   { controller: "pc_maps", action: "index", product_product_id: "#{@product.product_id}" }
  end

  # test route to pc_maps#show
  # nil

  # test route to pc_maps#new
  test "should route to pc_maps#new" do
    assert_routing "/products/#{@product.product_id}/pc_maps/new",
                   { controller: "pc_maps", action: "new", product_product_id: "#{@product.product_id}" }
  end

  # test route to pc_maps#create
  test "should route to pc_maps#create" do
    assert_routing({ method: 'post', path: "/products/#{@product.product_id}/pc_maps", product_product_id: "#{@product.product_id}" },
                   { controller: "pc_maps", action: "create", product_product_id: "#{@product.product_id}" })
  end

  # test route to paymethods#edit
  # nil

  # test route to paymethods#update
  # nil

  # test route to pc_maps#destroy
  test "should route to pc_maps#destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}/pc_maps/#{@pc_map.custom_id}" },
                   { controller: "pc_maps", action: "destroy", product_product_id: "#{@product.product_id}", custom_id: "#{@pc_map.custom_id}" })
  end

  # ---------- test resources solds ---------------------------------
  # test route to solds#index
  test "should route to solds#index" do
    assert_routing "/products/#{@product.product_id}/solds",
                   { controller: "solds", action: "index", product_product_id: "#{@product.product_id}" }
  end

  # test route to solds#show
  # nil

  # test route to solds#new
  test "should route to solds#new" do
    assert_routing "/products/#{@product.product_id}/solds/new",
                   { controller: "solds", action: "new", product_product_id: "#{@product.product_id}" }
  end

  # test route to solds#create
  test "should route to solds#create" do
    assert_routing({ method: 'post', path: "/products/#{@product.product_id}/solds", product_product_id: "#{@product.product_id}" },
                   { controller: "solds", action: "create", product_product_id: "#{@product.product_id}" })
  end

  # test route to solds#edit
  # nil

  # test route to solds#update
  # nil

  # test route to solds#destroy
  test "should route to solds#destroy" do
    assert_routing({ method: 'delete', path: "/products/#{@product.product_id}/solds/#{@sold.id}" },
                   { controller: "solds", action: "destroy", product_product_id: "#{@product.product_id}", id: "#{@sold.id}" })
  end

  # ---------- test resources shipments ---------------------------------
  # test route to shipments#index
  test "should route to shipments#index" do
    assert_routing "/shipments",
                   { controller: "shipments", action: "index" }
  end

  # test route to shipments#show
  test "should route to shipments#show" do
    assert_routing "/shipments/#{@shipment.shipment_id}",
                   { controller: "shipments", action: "show", shipment_id: "#{@shipment.shipment_id}" }
  end

  # test route to shipments#new
  test "should route to shipments#new" do
    assert_routing "/shipments/new",
                   { controller: "shipments", action: "new" }
  end

  # test route to shipments#create
  test "should route to shipments#create" do
    assert_routing({ method: 'post', path: '/shipments' },
                   { controller: "shipments", action: "create" })
  end

  # test route to shipments#edit
  test "should route to shipments#edit" do
    assert_routing "/shipments/#{@shipment.shipment_id}/edit",
                   { controller: "shipments", action: "edit", shipment_id: "#{@shipment.shipment_id}" }
  end

  # test route to shipments#update
  test "should route to shipments#update" do
    assert_routing({ method: 'patch', path: "/shipments/#{@shipment.shipment_id}" },
                   { controller: "shipments", action: "update", shipment_id: "#{@shipment.shipment_id}" })
  end

  # test route to shipments#destroy
  test "should route to shipments#destroy" do
    assert_routing({ method: 'delete', path: "/shipments/#{@shipment.shipment_id}" },
                   { controller: "shipments", action: "destroy", shipment_id: "#{@shipment.shipment_id}" })
  end

  # ---------- test resources shipment_details ---------------------------------
  # test route to shipment_details#index
  test "should route to shipment_details#index" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details",
                   { controller: "shipment_details", action: "index", shipment_shipment_id: "#{@shipment.shipment_id}" }
  end

  # test route to shipment_details#show
  # nil

  # test route to shipment_details#new
  test "should route to shipment_details#new" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details/new",
                   { controller: "shipment_details", action: "new", shipment_shipment_id: "#{@shipment.shipment_id}" }
  end

  # test route to shipment_details#create
  test "should route to shipment_details#create" do
    assert_routing({ method: 'post', path: "/shipments/#{@shipment.shipment_id}/shipment_details", id: "#{@shipment.shipment_id}" },
                   { controller: "shipment_details", action: "create", shipment_shipment_id: "#{@shipment.shipment_id}" })
  end

  # test route to shipment_details#edit
  test "should route to shipment_details#edit" do
    assert_routing "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}/edit",
                   { controller: "shipment_details", action: "edit", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" }
  end

  # test route to shipment_details#update
  test "should route to shipment_details#update" do
    assert_routing({ method: 'patch', path: "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}" },
                   { controller: "shipment_details", action: "update", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" })
  end

  # test route to shipment_details#destroy
  test "should route to shipment_details#destroy" do
    assert_routing({ method: 'delete', path: "/shipments/#{@shipment.shipment_id}/shipment_details/#{@shipment_detail.id}" },
                   { controller: "shipment_details", action: "destroy", shipment_shipment_id: "#{@shipment.shipment_id}", id: "#{@shipment_detail.id}" })
  end

  # ---------- test resources shipmethods ---------------------------------
  # test route to shipmethods#index
  test "should route to shipmethods#index" do
    assert_routing "/shipmethods",
                   { controller: "shipmethods", action: "index" }
  end

  # test route to shipmethods#show
  # nil

  # test route to shipmethods#new
  test "should route to shipmethods#new" do
    assert_routing "/shipmethods/new",
                   { controller: "shipmethods", action: "new" }
  end

  # test route to shipmethods#create
  test "should route to shipmethods#create" do
    assert_routing({ method: 'post', path: '/shipmethods' },
                   { controller: "shipmethods", action: "create" })
  end

  # test route to shipmethods#edit
  test "should route to shipmethods#edit" do
    assert_routing "/shipmethods/#{@shipmethod.shipmethod_id}/edit",
                   { controller: "shipmethods", action: "edit", shipmethod_id: "#{@shipmethod.shipmethod_id}" }
  end

  # test route to shipmethods#update
  test "should route to shipmethods#update" do
    assert_routing({ method: 'patch', path: "/shipmethods/#{@shipmethod.shipmethod_id}" },
                   { controller: "shipmethods", action: "update", shipmethod_id: "#{@shipmethod.shipmethod_id}" })
  end

  # test route to shipmethods#destroy
  test "should route to shipmethods#destroy" do
    assert_routing({ method: 'delete', path: "/shipmethods/#{@shipmethod.shipmethod_id}" },
                   { controller: "shipmethods", action: "destroy", shipmethod_id: "#{@shipmethod.shipmethod_id}" })
  end

  # ---------- test resources users ---------------------------------
  # test route to users#index
  test "should route to users#index" do
    assert_routing "/users",
                   { controller: "users", action: "index" }
  end

  # test route to users#show
  test "should route to users#show" do
    assert_routing "/users/#{@user.id}",
                   { controller: "users", action: "show", id: "#{@user.id}" }
  end

  # test route to users#new
  test "should route to users#new" do
    assert_routing "/signup",
                   { controller: "users", action: "new" }
  end

  # test route to users#create
  test "should route to users#create" do
    assert_routing({ method: 'post', path: '/users' },
                   { controller: "users", action: "create" })
  end

  # test route to users#edit
  test "should route to users#edit" do
    assert_routing "/users/#{@user.id}/edit",
                   { controller: "users", action: "edit", id: "#{@user.id}" }
  end

  # test route to users#update
  test "should route to users#update" do
    assert_routing({ method: 'patch', path: "/users/#{@user.id}" },
                   { controller: "users", action: "update", id: "#{@user.id}" })
  end

  # test route to users#destroy
  test "should route to users#destroy" do
    assert_routing({ method: 'delete', path: "/users/#{@user.id}" },
                   { controller: "users", action: "destroy", id: "#{@user.id}" })
  end

  # ---------- test resources sessions ---------------------------------
  # test route to sessions#index
  # nil

  # test route to sessions#show
  # nil

  # test route to sessions#new
  # nil

  # test route to sessions#create
  # nil

  # test route to sessions#edit
  # nil

  # test route to sessions#update
  # nil

  # test route to sessions#destroy
  # nil

  # ---------- test custom path ---------------------------------
  # test path /ajax/modus
  test "should get path /ajax/modus" do
    assert_routing "/ajax/modus",
                   { controller: "modus", action: "ajax_modus" }
  end

  # test path /ajax/auctions
  test "should get path /ajax/auctions" do
    assert_routing "/ajax/auctions",
                   { controller: "auctions", action: "ajax_auctions" }
  end

  # test path /ajax/customs
  test "should get path /ajax/customs" do
    assert_routing "/ajax/customs",
                   { controller: "customs", action: "ajax_customs" }
  end

  # test path /ajax/auction_percentage
  test "should get path /ajax/auction_percentage" do
    assert_routing "/ajax/auction_percentage",
                   { controller: "customs", action: "ajax_auction_percentage" }
  end

  # test path /auth/:provider/callback
  test "should get path /auth/:provider/callback" do
    assert_routing "/auth/yahoojp/callback",
                   { controller: "auctions", action: "callback", provider: "yahoojp" }
  end

  # test path /auth/:provider/logout
  test "should get path /auth/:provider/logout" do
    assert_routing "/auth/yahoojp/logout",
                   { controller: "auctions", action: "logout", provider: "yahoojp" }
  end

  # test path /auth/:provider/loaddata
  test "should get path /auth/:provider/loaddata" do
    assert_routing "/auth/yahoojp/loaddata",
                   { controller: "auctions", action: "loaddata", provider: "yahoojp" }
  end

  # test path signup
  test "should get path signup" do
    assert_routing "signup",
                   { controller: "users", action: "new" }
  end

  # test path login(get)
  test "should get path login" do
    assert_routing "login",
                   { controller: "sessions", action: "new" }
  end

  # test path login(post)
  test "should post path login" do
    assert_routing({ method: 'post', path: "login" },
                   { controller: "sessions", action: "create" } )
  end

  # test path logout
  test "should delete path logout" do
    assert_routing({ method: 'delete', path: "logout" },
                   { controller: "sessions", action: "destroy" } )
  end
end