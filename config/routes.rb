Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  resources :categories, param: :_slug
  resources :courses, param: :_slug
  resources :chapters, param: :_slug
  resources :lessons, param: :_slug

  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
  get '/*a', to: 'application#not_found'
end
