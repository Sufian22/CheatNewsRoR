Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'auth/:provider/callback', to: 'sessions#create', :via => 'get'
  get 'auth/failure', to: 'home#index'
  get '/signout', to: 'sessions#destroy', as: 'signout'


  namespace :api, defaults: { format: "json" } do
    #We are going to list our resources here
    resources :sessions, :only => [:create, :destroy]
    resources :users, :only => [:show, :create, :update, :destroy]
    resources :submissions, :only => [:show, :index, :create, :update, :destroy]
    resources :comments, :only => [:show, :index, :create, :update, :destroy]
    resources :replies, :only => [:show, :index, :create, :update, :destroy]
  end


  #resources :users
  #resources :sessions, only: [:create, :destroy]

  #resources :submissions do
  #  member do
  #    put "like", to: "submissions#upvote"
  #  end
  #end

  #resources :comments do
  #  member do
  #    put "like", to: "comments#upvote"
  #  end
  #end

  #resources :replies do
  #  member do
  #    put "like", to: "replies#upvote"
  #  end
  #end

  root 'home#index'
  
  #get 'home/news', as: 'newest'
  #get 'home/asks', as: 'asks'
  #get 'home/threads', as: 'threads'
  #get 'home/showuser'
  #get 'home/edituser'
  #get 'home/mysubmissions', as: 'mysubmissions'
  #get 'home/newcomment'
  #get 'home/newreply'
  #get 'home/newsubmission'
  #get 'home/createsubmission'
  #post 'home/createcomment'
  #post 'home/createreply'
  #post 'home/createsubmission'
  #patch 'home/updateuser'

end
