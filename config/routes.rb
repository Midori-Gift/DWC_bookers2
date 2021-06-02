Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
  resource :favorites, only: [:create, :destroy]
  resource :comments, only: [:create, :destroy]

  end

  resources :users, only: [:show, :index, :edit, :update, :create]


end