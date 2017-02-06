Rails.application.routes.draw do

  resources :users

  get "users/new"

  get "static_pages/home"

  get "/help", to: "static_pages#help", as: "helf"

  get "/about", to: "static_pages#about"

  get "/contact", to: "static_pages#contact"

  get "signup", to: "users#new"

  root "static_pages#home"
  
  scope "(:locale)", :locale => /en|vn/ do
    root "static_pages#home"
    get "static_pages/home"
  end

end
