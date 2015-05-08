Rails.application.routes.draw do

  get    '/ajax/modus'              => 'modus#ajax_modus'
  get    '/ajax/auctions'           => 'auctions#ajax_auctions'
  get    '/ajax/customs'            => 'customs#ajax_customs'
  get    '/ajax/auction_percentage' => 'customs#ajax_auction_percentage'
  get    '/auth/:provider/callback' => 'auctions#callback' #戻り先
  get    '/auth/:provider/logout'   => 'auctions#logout'   #ログアウト
  get    '/auctions/initload'        => 'auctions#initload' #ロード画面初期化
  get    '/auth/:provider/loaddata1'=> 'auctions#load_won_data' #ロードデータ
  get    '/auth/:provider/loaddata2'=> 'auctions#load_closed_data' #ロードデータ
  post   '/auctions/search'         => 'auctions#search'
  post   '/products/search'         => 'products#search'
  post   '/customs/search'          => 'customs#search'
  post   '/shipments/search'        => 'shipments#search'
  post   '/summaries/search'        => 'summaries#search'
  get    '/popup/product'           => 'products#ajax_popup_product', as: 'popup_product'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :auctions, param: :auction_id
  resources :brands, param: :brand_id, :except => [:show] do
    resources :modus, param: :modu_id, :except => [:show]
  end
  resources :categories, param: :category_id, :except => [:show]
  resources :customs, param: :custom_id
  resources :paymethods, param: :paymethod_id, :except => [:show]
  resources :products, param: :product_id do
    resources :pa_maps, param: :auction_id, :except => [:edit, :update, :show]
    resources :pc_maps, param: :custom_id, :except => [:edit, :update, :show]
    resources :solds
  end
  resources :shipments, param: :shipment_id do
    resources :shipment_details, param: :id, :except => [:show]
  end
  resources :shipmethods, param: :shipmethod_id, :except => [:show]
  resources :summaries, :only => [:index]
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboards#show'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
