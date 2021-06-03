Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]

  end

  #resources :relations, only

  resources :users, only: [:show, :index, :edit, :update, :create]

  resources :follower, class_name: "User", only: [:show]
  resources :followed, class_name: "User", only: [:show]



  post 'follow/:id' => 'relationships#follow', as: 'follow'

  post'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
end