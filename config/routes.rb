Wordnursery::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users"}

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root to: "home#index"

  post "/words/update_word_list" => "words#update_word_list"

  resources :words

  resources :users do
    resources :lists
  end

  get "/search" => "search#index"

end
