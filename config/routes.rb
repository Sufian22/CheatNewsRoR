Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount_devise_token_auth_for 'User', at: 'auth'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/admin')
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resources :submissions
  resources :replies
  resources :comments
  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :submissions do
    member do
      put "like", to: "submissions#upvote"
    end
  end

  resources :comments do
    member do
      put "like", to: "comments#upvote"
    end
  end

  resources :replies do
    member do
      put "like", to: "replies#upvote"
    end
  end

  root 'home#index'
  
  get 'home/news'
  get 'home/asks'
  get 'home/newcomment'
  get 'home/newreply'
  get 'home/newsubmission'
  get 'home/createsubmission'
  post 'home/createcomment'
  post 'home/createreply'
  post 'home/createsubmission'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
