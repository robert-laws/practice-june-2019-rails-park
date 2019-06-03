Rails.application.routes.draw do
  root "sessions#index"

  resources :users, only: [:new, :show, :create]
end