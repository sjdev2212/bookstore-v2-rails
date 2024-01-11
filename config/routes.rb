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
    resources :favorites, only: [:create, :destroy]
    post 'favorites/:user_id/:book_id', to: 'favorites#create', as: :add_favorite
    delete 'favorites/:user_id/:book_id', to: 'favorites#destroy', as: :remove_favorite
  end
  resources :users, only: [:create]
  post 'register', to: 'users#create'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
