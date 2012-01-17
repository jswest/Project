Project::Application.routes.draw do
  resources :friendships

  resources :groups
  resources :saved_articles

  match 'shared_articles/sent' => 'shared_articles#sent'
  resources :shared_articles
  resources :articles
  match 'users/search' => 'users#search'
  match 'users/update_front_page' => 'users#update_front_page', :method => :post
  resources :users

  match 'sessions/destroy' => 'sessions#destroy'
  match 'sessions/new' => 'sessions#new'
  match 'sessions/create' => 'sessions#create'
  match 'frontpage' => 'front_page#index'
  
  root :to => 'users#new'
  
end
