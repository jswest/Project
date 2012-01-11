Project::Application.routes.draw do
  resources :friendships

  resources :groups

  resources :saved_articles
  resources :shared_articles
  resources :articles
  resources :users

  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  match 'users/myshared' => 'users#myshared'
  
  root :to => 'users#new'
  
end
