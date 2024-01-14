Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  devise_for :users
end
