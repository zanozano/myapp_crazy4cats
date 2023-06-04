Rails.application.routes.draw do
  resources :likes

  resources :posts do
    member do
      post :create_like
    end

    resources :likes, only: [:index, :create], module: :posts
    resources :comments, only: [:create, :destroy]
  end

  devise_for :users
  root "posts#index"
end
