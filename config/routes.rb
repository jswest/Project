Project::Application.routes.draw do
  resources :shared_articles
  resources :articles
  resources :users

end
