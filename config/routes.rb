Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:show]
  resources :tags
  resources :ads do
    member do
      put :archive
      put :unarchive
    end
  end
  resources :categories
end
