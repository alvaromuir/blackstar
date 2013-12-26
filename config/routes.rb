Blackstar::Application.routes.draw do
  root "categories#index"

  resources :categories do
    resources :topics
  end
end
