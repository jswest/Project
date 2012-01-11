Project::Application.routes.draw do
  resources :saved_articles

  #resources :sessions
  resources :shared_articles
  resources :articles
  resources :users
  
  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  match 'users/myshared' => 'users#myshared'
  match 'users/mysaved' => 'users#mysaved'
  
  root :to => 'users#new'
  
end
