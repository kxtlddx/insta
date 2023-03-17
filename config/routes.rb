Rails.application.routes.draw do
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_scope :user do
    get '/users' => 'devise/registration#new'
    get '/users/password' => 'devise/password#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users, :controllers => {
    registrarions: 'users/registrations'
      }

  resources :users, only: [:show, :index]

  match '/users',   to: 'users#index',   via: 'get'

  get 'posts/myposts'

  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
