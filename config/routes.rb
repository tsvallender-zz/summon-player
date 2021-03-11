Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/new'
  get 'messages/create'
  get 'categories/index'
  get 'categories/show'
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:show]
  resources :messages, only: [:index, :show, :new, :create]
  resources :tags
  resources :ads do
    member do
      put :archive
      put :unarchive
    end
  end
  resources :categories

  mount ActionCable.server, at: '/cable'
end
