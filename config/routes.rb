Rails.application.routes.draw do
  resources :reviews

  resources :workouts, only: [:show, :index, :create, :destroy] do
    resources :reviews, only: [:show, :index]
  end

  resources :users do
    resources :workouts, only: [:show, :index]
  end

  resources :users do
    resources :reviews, only: [:show, :index]
  end

  
  
 post "/signup", to: "users#create"
 get "/me", to: "users#show"
 post "/login", to: "sessions#create"
 delete "/logout", to: "sessions#destroy"
 get "/workouts/review_length/:n", to: "workouts#review_length"
  
  
  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
