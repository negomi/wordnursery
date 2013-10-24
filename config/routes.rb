Wordnursery::Application.routes.draw do
  devise_for :users

  root :to => "home#index"

  get "/word", :to => "words#search"

  get "log_out" => "sessions#destroy", :as => "log_out"

  get "log_in" => "sessions#new", :as => "log_in"

  get "sign_up" => "users#new", :as => "sign_up"

  resources :users

  resources :sessions



  get "home/index"

  get "lists/index"

  get "lists/show"

  get "lists/new"

  get "lists/create"

  get "lists/edit"

  get "lists/update"

  get "lists/delete"

  get "words/index"

  get "words/show"

  get "words/new"

  get "words/create"

  get "words/edit"

  get "words/update"

  get "words/delete"

  get "users/index"

  get "users/show"

  get "users/new"

  get "users/create"

  get "users/edit"

  get "users/update"

  get "users/delete"
end
