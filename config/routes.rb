Rails.application.routes.draw do
  resources :users
  resources :articles, param: :slug
  resources :comments

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
