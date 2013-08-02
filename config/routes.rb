Rails.application.routes.draw do
  root 'app#index'

  devise_for :users

  resources :groups
  resources :memberships
  resources :users
end