Wordnursery::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users"}

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root to: "home#index"

  resources :words

  resources :users do
    resources :lists
  end

  get "/search" => "search#index"

  post "/change" => "words#change_word_list"
end
