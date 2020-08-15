Rails.application.routes.draw do
  root "homes#index"
  resources :posts
  devise_for :users
end
