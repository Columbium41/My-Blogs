# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: "main#index"
  
  get "/about", to: "about#index"

  get "/account", to: "account#index"
  
  get "/sign_up", to: "registrations#new"
  post "/sign_up", to: "registrations#create", as: :create_account
  delete "/sign_up", to: "registrations#destroy", as: :delete_account

  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create", as: :sign_into_account

  delete "/logout", to: "sessions#destroy"

  get "/password", to: "passwords#edit", as: :edit_password
  patch "/password", to: "passwords#update"

  get "/password/reset", to: "passwords_reset#new", as: :forgot_password
  post "/password/reset", to: "passwords_reset#create"
  get "/password/reset/edit", to: "passwords_reset#edit"
  patch "/password/reset/edit", to: "passwords_reset#update"
end
