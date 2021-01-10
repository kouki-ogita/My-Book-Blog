Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
      get :categories
    end 
  end 
  
  resources :posts do
    resources :comments, only: [:create]
    member do 
      get :favoriteds
    end 
  end 
  
  resources :categories, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :comments, only: [:edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
