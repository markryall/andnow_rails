AndnowServer::Application.routes.draw do
  resources :sessions
  post 'sessions/import' => 'sessions#import'
  resource :user, :only => [:show, :update]
  get 'home' => 'home#index'
  get 'home/login' => 'home#login', as: 'login'
  get 'home/logout' => 'home#logout', as: 'logout'
  get 'activity/:activity' => 'activity#show', as: 'activity'
  post 'home/verify' => 'home#verify', as: 'verify'
  root :to => 'home#index'
end