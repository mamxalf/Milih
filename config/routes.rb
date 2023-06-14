# frozen_string_literal: true

Rails.application.routes.draw do
  # qna's
  resources :qna_rooms
  post 'qna_questions/ask_question'
  get 'qna_questions/form'

  # polling's
  resources :pollings do
    collection do
      get 'user/status', to: 'user_polling#redirect_status_page', as: 'user_status'
      get 'user/:code', to: 'user_polling#form', as: 'user_polling'
      post 'user/submit', to: 'user_polling#submit', as: 'user_submit'
    end
  end
  # resources :polling_answers

  # dashboard index
  get 'dashboards', to: 'dashboard#index'

  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  # root "articles#index"

  # mount action cable
  mount ActionCable.server => '/cable'
end
