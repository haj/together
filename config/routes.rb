Rails.application.routes.draw do
  devise_for :users

  resources :groups
  resources :memberships
  resources :users
end