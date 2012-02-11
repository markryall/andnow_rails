AndnowServer::Application.routes.draw do
  resources :sessions
  resource :user, :only => [:show, :update]
  get 'home' => 'home#index'
  get 'home/login' => 'home#login', as: 'login'
  get 'home/logout' => 'home#logout', as: 'logout'
  post 'home/verify' => 'home#verify', as: 'verify'
  root :to => 'home#index'
end