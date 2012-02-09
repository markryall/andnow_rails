AndnowServer::Application.routes.draw do
  resources :sessions
  match 'home' => 'home#index'
  match 'home/login' => 'home#login', as: 'login'
  match 'home/logout' => 'home#logout', as: 'logout'
  match 'home/verify' => 'home#verify', as: 'verify'
  root :to => 'home#index'
end