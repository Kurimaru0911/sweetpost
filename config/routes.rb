Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :favorites
      get :wents
    end
  end
  
  resources :sweets, only: [:create, :destroy, :show] do
      resources :comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:index, :create, :destroy]
  resources :wents, only: [:index, :create, :destroy]
end