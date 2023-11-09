Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/create'

  resources :books

  namespace :api do
    resources :books do
      collection do
        get 'filter_title'
        get 'filter_author'
        get 'filter_price'
      end
    end
  end
  resources :users, only: [:create]
  post 'register', to: 'users#create'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
