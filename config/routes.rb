Blackstar::Application.routes.draw do
  root "categories#index"

  resources :categories do
    resources :topics
  end

  resources :users
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  namespace :admin do
    root :to => "base#index"
    resources :users
  end
end
