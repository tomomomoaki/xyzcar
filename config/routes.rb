Rails.application.routes.draw do
  devise_for :users
  
  root to: 'cars#index'
  resources :cars do
    resources :comments, only: :create
    collection do
      get 'search_tag'
      get 'search'
      get 'squeeze'
    end
  end

  resources :users, only: :show
end