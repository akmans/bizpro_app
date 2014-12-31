Rails.application.routes.draw do

  get    '/ajax/modus'              => 'modus#ajax_modus'
  get    '/ajax/auctions'           => 'auctions#ajax_auctions'
  get    '/ajax/auction_percentage' => 'customs#ajax_auction_percentage'
  get    '/auth/:provider/callback' => 'auctions#callback' #戻り先
  get    '/auth/:provider/logout'   => 'auctions#logout'   #ログアウト
  get    '/auth/:provider/loaddata' => 'auctions#loaddata' #ロードデータ
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :categories, param: :category_id, :except => [:show]
  resources :brands, param: :brand_id, :except => [:show] do
    resources :modus, param: :modu_id, :except => [:show]
  end
  resources :paymethods, param: :paymethod_id, :except => [:show]
  resources :shipmethods, param: :shipmethod_id, :except => [:show]
  resources :users
  resources :auctions, param: :auction_id
  resources :customs, param: :custom_id
  resources :products, param: :product_id
  resources :shipments, param: :shipment_id do
    resources :shipment_details, param: :id, :except => [:show]
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'auctions#index'

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
