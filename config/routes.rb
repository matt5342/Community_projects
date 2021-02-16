Rails.application.routes.draw do
  resources :projects
  resources :communities
  resources :users
  resources :user_projects, only: [:new, :index, :create]
  # get '/users/:id/back_project', to: 'users#new_back_project', as: 'back_project'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
