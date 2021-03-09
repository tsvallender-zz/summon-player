Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:show]
  resources :tags
  resources :ads
end
