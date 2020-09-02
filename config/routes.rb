Rails.application.routes.draw do
  root "homes#index"
  devise_for :users
  resources :posts
  resources :users, only: :show
end
