Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "ideas#index", as: :authenticated_root      # if a user is logged in it takes them to ideas
  end

  unauthenticated do
    root to: "pages#home", as: :unauthenticated_root    # if a user is not logged in it to them to home
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  resources :initial_questions, only: [:show, :create, :new]
  resources :expanded_questions, only: [:show, :create, :new]

  # Defines the route for the posts index and show
  resources :posts, only: [:index, :show] do
    resources :feedbacks, only: [:create]
  end

  # Defines the routes for the upvote action
  resources :posts do
    member do
      post 'upvote'
      get 'upvote'
    end
  end

  resources :feedbacks do
    member do
      post 'upvote'
    end
  end

  resources :replies do
    member do
      post 'upvote'
    end
  end

  resources :feedbacks, except: [:create] do
    resources :replies, only: [:create]
  end

  # Define route for the UI Kit page
  get "ui_kit", to: "pages#ui_kit", as: :ui_kit
  resources :ideas, only: %i[index edit update]
end
