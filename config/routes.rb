# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: "main#index"
  
  get "/about", to: "about#index"
  

  # Account Routes
  get "/sign_up", to: "registrations#new"
  post "/sign_up", to: "registrations#create", as: :create_account

  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create", as: :sign_into_account

  delete "/logout", to: "sessions#destroy"

  get "/password", to: "passwords#edit", as: :edit_password
  patch "/password", to: "passwords#update"

  get "/password/reset", to: "passwords_reset#new", as: :forgot_password
  post "/password/reset", to: "passwords_reset#create"
  get "/password/reset/edit", to: "passwords_reset#edit"
  patch "/password/reset/edit", to: "passwords_reset#update"

  get "/account", to: "account#index"
  get "/delete", to: "account#destroy"
  delete "/account", to: "account#delete", as: :delete_account


  # Blog Routes
  get "/blogs", to: "blogs#index"
  get "/blogs/:id", to: "blogs#show", as: :blog

end
