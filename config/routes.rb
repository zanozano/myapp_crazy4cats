Rails.application.routes.draw do
  resources :likes
  
  resources :posts do
    resources :likes, only: [:index], module: :posts
    resources :comments, only: [:create, :destroy]
  end
  
  devise_for :users
  root "posts#index"
end
