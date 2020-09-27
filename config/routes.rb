Rails.application.routes.draw do
  root "homes#index"

  devise_for :users, skip: :all
  devise_scope :user do
    get "login" => "users/sessions#new", as: :new_user_session
    post "login" => "users/sessions#create", as: :user_session
    delete "logout" => "users/sessions#destroy", as: :destroy_user_session
    get "signup" => "users/registrations#new", as: :new_user_registration
    post "signup" => "users/registrations#create", as: :user_registration
    get "signup/cancel" => "users/registrations#cancel", as: :cancel_user_registration
    get "user" => "users/registrations#edit", as: :edit_user_registration
    get "settings/password" => "users/registrations#change_password", as: :change_password_user_registration
    patch "user" => "users/registrations#update", as: nil
    put "user" => "users/registrations#update", as: :update_user_registration
    delete "user" => "users/registrations#destroy", as: :destroy_user_registration
    get "deactivate" => "users/registrations#deactivate", as: :deactivate_user_registration
    get "password" => "users/passwords#new", as: :new_user_password
    post "password" => "users/passwords#create", as: :user_password
    get "password/edit" => "users/passwords#edit", as: :edit_user_password
    patch "password" => "users/passwords#update"
    put "password" => "users/passwords#update", as: :update_user_password
  end

  resources :users, only: :show do
    resource :relationships, only: [:create, :destroy]
    member do
      get :favorites
      get :followings
      get :followers
    end
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
end
