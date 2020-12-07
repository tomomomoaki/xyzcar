Rails.application.routes.draw do
  devise_for :users
  
  root to: 'cars#index'
  resources :cars do
    resources :comments, only: :create
    collection do
      get 'search_tag'
      get 'search'
      get 'type'
    end
  end

  resources :users, only: :show
  resources :notifications, only: :index do
    collection do
      get 'search_notification'
    end
  end
end