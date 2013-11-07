Wordnursery::Application.routes.draw do
  devise_for :users

  root to: "home#index"

  resources :words

  resources :users do
    resources :lists
  end

  get "/search" => "search#index"

  post "/words" => "words#create"

end
