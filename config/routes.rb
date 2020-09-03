Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :posts
  resources :users, only: :show
end
