Project::Application.routes.draw do
  #resources :sessions
  resources :shared_articles
  resources :articles
  resources :users
  
  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  
  root :to => 'users#new'
  
end
