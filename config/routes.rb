OakVale::Application.routes.draw do
  get "password_resets/new"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'
  get '/hot' => 'application#hot'

  #sign
  resources :sessions, only:[:new, :create, :destroy]
  get '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  #sign up
  get '/signup' => 'users#new'

  #users
  get 'users/:id/favorites' => 'users#favorites'

  resources :users, only: [:show, :edit, :update, :create, :favorites] do  
    get 'posts' => 'posts#index'
    member do
      get 'followers', 'following'
    end
  end

  #groups
  resources :groups, only: [:index, :show, :new, :edit, :update, :create] do  
    resources :topics do
      resources :replies, only:[:create, :destroy]
    end
  end

  #notifications
  resources :notifications, only: [:index, :destroy] do
    collection do
      post :clear
    end
  end

  #settings
  resources :password_resets

  #relationships
  resources :relationships, only: [:create, :destroy]

  #posts
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  post 'tags/:id/subscribe' => 'tags#subscribe'
  post 'groups/:id/join' => 'groups#join'
  post 'posts/:id/like' => 'posts#like'

  #tags
  resources :tags


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
