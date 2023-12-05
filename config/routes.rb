# frozen_string_literal: true

require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    user_id = request.session[:user_id] || request.cookie_jar.encrypted[:user_id]

    User.find_by(id: user_id)&.admin_role?
  end
end

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
  get 'up' => 'rails/health#show', as: :rails_health_check

  concern :likeable do
    member do
      post 'like'
      delete 'unlike'
    end
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resource :session, only: %i[new create destroy]
    resource :password_reset, only: %i[new create edit update]

    resources :users, only: %i[new create edit update]

    resources :questions do
      resources :comments, only: %i[create destroy], module: :questions
      resources :answers, except: %i[new show], concerns: :likeable
      concerns :likeable
    end

    resources :answers, only: [] do
      resources :comments, only: %i[create destroy], module: :answers, concerns: :likeable
      concerns :likeable
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
