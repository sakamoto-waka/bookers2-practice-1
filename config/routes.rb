Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get "follows" => "relationships#follow_users"
    get "followers" => "relationships#follower_users"
  end
  get 'search' => "searches#ransack_search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end