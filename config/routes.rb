Project::Application.routes.draw do
  resources :saved_articles
  resources :shared_articles
  resources :articles
  resources :users

  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  match 'shared_articles/sent' => 'shared_articles#sent'
  
  root :to => 'users#new'
  
end
