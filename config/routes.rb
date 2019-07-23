Rails.application.routes.draw do
  devise_for :users
  root to: 'requests#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :requests, only: [:new, :create, :show] do
    member do
      get 'confirmation'
      get 'reconfirmation'
    end
  end
end
