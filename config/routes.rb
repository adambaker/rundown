Rundown::Application.routes.draw do
  get "pages/home"
  root to: 'pages#home'

  resources :items, except: [:edit]
  resources :users, except: [:edit, :new]

  resource  :sessions, only: [:create, :destroy]
  match '/signout' => 'sessions#destroy', as: :sign_out
  match "/auth/:provider/callback" => "sessions#create"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
end
