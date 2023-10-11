Rails.application.routes.draw do
  #get 'search/index'
  resources :quotes
  resources :categories
  resources :sources
  resources :users
  #get 'about/index'
  #get 'home/index'
  root 'home#index'
  get '/about', to: 'about#index'
  get '/search', to: 'search#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
