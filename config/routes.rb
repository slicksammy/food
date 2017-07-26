Rails.application.routes.draw do
  get 'checkout/view'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  get '/places' => 'application#places'

  get '/places/:id' => 'application#place', constraints: { id: /[0-9]+/ }

  post '/places/:id/notes' => 'application#notes'

  post '/places/:id/update_status' => 'application#update_status'

  get '/places/:id/callbacks' => 'application#get_callbacks'

  match 'places/new', to: 'application#new', via: [:get, :post]

  # get 'places/new' => 'application#new'

  get '/search' => 'application#search'


  # START STORE
  get '/store' => 'store#index'

  # START CART
  get '/cart' => 'cart#view'
  get '/cart/test' => 'cart#test'
  post '/cart' => 'cart#update'

  # START CHECKOUT
  get '/checkout' => 'checkout#view'
  post '/checkout/buy' => 'checkout#buy'
  post '/order/update' => 'checkout#update_order'
  post '/order/confirm' => 'checkout#confirm_order'

  # START PAYMENTS
  get '/payment' => 'payments#new'
  post '/payment/update' => 'payments#update'

  # START ADDRESSES
  get '/address' => 'address#new'
  post '/address' => 'address#save'
  post '/address/availability' => 'address#check_availability'

  # START USERS
  get '/signup' => 'users#signup'
  post '/users/create' => 'users#create'

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
