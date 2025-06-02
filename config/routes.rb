Rails.application.routes.draw do
  devise_for :users

  # Set root path
  root "home#index"

  # Protected routes that require authentication
  authenticate :user do
    resources :habits do
      resources :habit_checkins, only: [:create, :destroy]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
