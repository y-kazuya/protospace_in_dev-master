Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  get '/prototypes/newest', to: 'prototypes#newest'
  resources :prototypes do
    resources :captured_images, only: [:create, :update, :destroy]
    resources :comments , only: [:create, :edit, :update, :destroy]
  end
  resources :tags, only: [:index,:show] # id: '/^[a-z]+$/'idを拡張してurlにタグ名で表示
  resources :users, only: [:show, :edit, :update]
end
