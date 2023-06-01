# frozen_string_literal: true

Rails.application.routes.draw do
  # polling's
  resources :pollings

  # dashboard index
  get 'dashboards', to: 'dashboard#index'

  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  # root "articles#index"
end
