Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  root to: "users#index"

  # Routes for main resources

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [ :new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # API routes
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "users/sign_up" => "users#register"
      post "users/sign_in" => "users#login"
      get "posts" => "posts#index"
      get "comments" => "comments#index"
      post "comments" => "comments#create"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
