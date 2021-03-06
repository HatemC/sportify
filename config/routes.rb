Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :chatrooms, only: [:show, :new, :create] do
    resources :messages, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:edit, :update, :destroy]
  get 'dashboard', to: 'dashboard#dashboard'
  get 'conversations', to: 'conversations#conversations'
end
