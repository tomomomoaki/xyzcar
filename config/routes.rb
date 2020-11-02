Rails.application.routes.draw do
  devise_for :users
  
  root to: 'cars#index'
  resources :cars do
    resources :comments, only: :create
  end

  resources :user, only: :show
end