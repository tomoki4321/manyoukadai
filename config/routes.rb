Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:new, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
