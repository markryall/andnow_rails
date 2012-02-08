AndnowServer::Application.routes.draw do
  resources :sessions
  match 'home' => 'home#index'
  match 'home/login' => 'home#login'
  match 'home/logout' => 'home#logout'
  match 'home/verify' => 'home#verify'
  root :to => 'home#index'
end
