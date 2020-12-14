Rails.application.routes.draw do
  
  root to: 'cars#index'
  resources :cars do
    resources :comments, only: :create
    collection do
      get 'search_tag'
      get 'search'
      get 'type'
    end
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
   }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: :show 

  resources :notifications, only: :index do
    collection do
      get 'search_notification'
    end
  end
end