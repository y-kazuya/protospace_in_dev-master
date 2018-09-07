Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :show, :destroy] do
    resources :captured_images, only: [:create, :update, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
end
