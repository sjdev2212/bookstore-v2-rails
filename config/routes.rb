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
    resources :favorites, only: [:create, :destroy, :index, :favorite_per_user]
    post 'favorites/:user_id/:book_id', to: 'favorites#create', as: :add_favorite
    delete 'favorites/:user_id/:book_id', to: 'favorites#destroy', as: :remove_favorite
    get 'favorites/:user_id', to: 'favorites#favorite_per_user', as: :favorite_per_user
  end
  resources :users, only: [:create]
  post 'register', to: 'users#create'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
