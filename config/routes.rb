Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
  get '/users' => 'devise/registration#new'
  get '/users/password' =>  'devise/password#new'
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
