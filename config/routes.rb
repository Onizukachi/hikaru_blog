Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users, only: %i[new create]

  resources :questions do
    resources :answers, except: %i[new show]
  end

  root 'pages#index'
end
