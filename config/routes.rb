# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create edit update]

  resources :questions do
    resources :answers, except: %i[new show]
  end

  namespace :admin do
    resources :users, only: %i[index]
  end

  root 'pages#index'
end
