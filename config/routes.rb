Rails.application.routes.draw do
  resources :posts
  resources :posts do
  resources :comments, only: [:create]
  end
  devise_for :users
  root "posts#index"
end
