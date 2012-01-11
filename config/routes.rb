Project::Application.routes.draw do
  resources :shared_articles
  resources :articles
  resources :users

  match 'articles/new' => 'articles#new'
  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  
  root :to => 'users#new'
  
end
