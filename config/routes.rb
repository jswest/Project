Project::Application.routes.draw do
  resources :friendships

  resources :groups
  match 'shared_articles/sent' => 'shared_articles#sent'

  resources :saved_articles
  resources :shared_articles
  resources :articles
  match 'users/search' => 'users#search'
  resources :users

  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  
  root :to => 'users#new'
  
end
