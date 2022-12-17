Rails.application.routes.draw do
  root "sessions#new"
  resources :tasks do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
