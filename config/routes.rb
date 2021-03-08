Rails.application.routes.draw do
  get 'tags/new'
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:show]
  resources :tags
  resources :ads
  #get 'users/:id' => 'users#show'
end
