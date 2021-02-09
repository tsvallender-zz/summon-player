Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:show]
end
