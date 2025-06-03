Rails.application.routes.draw do
  get 'habit_checkins/create'
  get 'habit_checkins/destroy'
  get 'habits/index'
  get 'habits/show'
  get 'habits/new'
  get 'habits/create'
  get 'habits/edit'
  get 'habits/update'
  get 'habits/destroy'
  devise_for :users

  authenticated :user do
    root 'habits#index', as: :authenticated_root
    resources :habits do
      member do
        get :confirm_delete
        get :cancel_delete
        get :calendar
      end
      resources :habit_checkins, only: [:create, :destroy]
    end
  end

  root 'home#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
