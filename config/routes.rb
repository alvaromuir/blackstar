Blackstar::Application.routes.draw do
  root "categories#index"

  resources :categories
end
