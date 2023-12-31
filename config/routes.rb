# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'sessions#new'
  post '/auth/login', to: 'api/authentication#login'

  namespace :api do
    namespace :v1 do
      resources :transactions, only: %i[create]
    end
  end

  resources :transactions, only: %i[index]
  resources :sessions, only: %i[create]
  resources :merchants, only: %i[edit update destroy index]
end
