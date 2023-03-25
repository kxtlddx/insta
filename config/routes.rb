Rails.application.routes.draw do
  get 'profiles/index'
  get '/profiles', to: 'profiles#users'
  get '/profiles', to: 'profiles#search_query'
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_scope :user do
    get '/users' => 'devise/registrations#new'
    get '/users/password' => 'devise/passwords#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users, :controllers => {
    registrarions: 'users/registrations'
      }

  resources :users, only: [:show, :index]

  match '/users',   to: 'users#index',   via: 'get'

  post 'users/:id/follow', to: "users#follow", as: "follow"
  post 'users/:id/unfollow', to: "users#unfollow", as: "unfollow"

  get 'posts/myposts'

  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
