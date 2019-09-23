Rails.application.routes.draw do
  # devise_for :users
  root to: 'requests#new'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :requests, only: [:new, :create, :show] do
    member do
      get 'confirmation'
      get 'reconfirmation'
    end
  end

  resources :desks, only: [:index, :show, :update] do
    resources :bookings, only: [:index, :show, :create]
  end

  resources :bookings, only: [:index, :show] do
    collection do
      get 'admin'
      get 'my_reservations'
      get 'pdf_ready'
    end
  end

  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
