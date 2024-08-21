Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Sessions routes
  get "sessions/new", to: "sessions#new", as: :new_session
  post "sessions/create", to: "sessions#create", as: :create_session
  delete "sessions/destroy", to: "sessions#destroy", as: :destroy_session

  # Wallets routes
  resources :wallets, only: [:show, :update]

  # Transactions routes
  resources :transactions, only: [:create]


  # config/routes.rb

  # Stocks routes
  get 'stocks/prices', to: 'stocks#prices', as: :stock_prices
  get 'stocks/:Search', to: 'stocks#show', as: :stock_price
  resources :stocks, only: [:index]

  resources :teams, only: [:index, :show]

  # Root path route
  root "wallets#index"
end
