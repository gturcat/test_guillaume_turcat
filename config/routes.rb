Rails.application.routes.draw do
  # devise_for :users
  root to: 'requests#new'
  get 'shared/header'

  #notification de request
  mount ActionCable.server, at: '/cable'

  #Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  require "sidekiq/cron/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :requests, only: [:new, :create, :show] do
    member do
      get 'confirmation'
      get 'reconfirmation'
    end
  end

  resources :messages, only: [:new, :create, :show]

  resources :desks, only: [:index, :new, :create, :show, :update, :edit] do
    resources :bookings, only: [:index, :show, :create]
  end

  resources :bookings, only: [:index, :show] do
    collection do
      get 'admin'
      get 'my_reservations'
      get 'pdf_ready'
      post 'import'
      get 'header'
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
