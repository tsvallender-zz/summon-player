Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: "static_pages#home"
  resources :users, only: [:show]
  resources :messages, only: [:index, :show, :new, :create]
  resources :chats, only: [:index, :show, :new, :create]
  resources :tags
  resources :ads do
    member do
      patch :archive
      patch :unarchive
      get   :messages
    end
  end
  resources :categories

  mount ActionCable.server, at: '/cable'
end
