Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :questions do
    resources :answers, only: %i[create destroy]
  end

  root 'questions#index'
end
