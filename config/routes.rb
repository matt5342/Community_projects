Rails.application.routes.draw do


  get 'home/welcome'
  root "home#welcome"
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'back/:id', to: 'users#back_project', as: 'back_this_project'
  get 'unback/:id', to: 'users#unback_project', as: 'unback_this_project'
  get 'join/:id', to: 'users#join_community', as: 'join_this_community'
  resources :projects
  resources :communities
  resources :users
  resources :sessions
  resources :user_projects, only: [:new, :index, :create]



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
