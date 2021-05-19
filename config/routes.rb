Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit]
  resources :users, only: [:show, :index, :edit, :update, ]

end
