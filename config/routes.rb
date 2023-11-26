# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    resources :questions do
      resources :comments, only: %i[create destroy], module: :questions
      resources :answers, except: %i[new show]
    end

    resources :answers, only: [] do
      resources :comments, only: %i[create destroy], module: :answers
    end

    namespace :admin do
      resources :users, only: %i[index create edit update destroy] do
        get 'ban', on: :member
        get 'unban', on: :member
      end

    end

    root 'pages#index'
  end
end
