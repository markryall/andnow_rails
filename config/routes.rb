AndnowServer::Application.routes.draw do
  resources :sessions, :except => [:show]
  post 'sessions/import' => 'sessions#import'

  resource :user, :only => [:show, :update]

  resources :tokens, :only => [:destroy, :create]

  get 'home' => 'home#index'
  get 'home/login' => 'home#login', as: 'login'
  get 'home/logout' => 'home#logout', as: 'logout'
  post 'home/verify' => 'home#verify', as: 'verify'

  get 'activity/:activity' => 'activity#show', as: 'activity'

  root :to => 'home#index'
end