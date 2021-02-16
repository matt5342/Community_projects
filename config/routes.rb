Rails.application.routes.draw do
  root "users#welcome"
  resources :projects
  resources :communities
  resources :users
  resources :user_projects, only: [:new, :index, :create]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
