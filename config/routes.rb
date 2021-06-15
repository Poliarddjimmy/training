Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username, exep: [:edit]
  resources :categories, param: :_slug, exep: [:edit]
  resources :courses, param: :_slug, exep: [:edit]
  resources :chapters, param: :_slug, exep: [:edit]
  resources :lessons, param: :_slug, exep: [:edit]
  resources :course_users, param: :id, exep: [:show, :edit]
  resources :requirements, param: :id, exep: [:index, :edit]
  resources :lesson_users, param: :id, exep: [:show, :edit]

  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

  get '/users/subscribe/:_course_slug', to: 'users#subscribe'
  get '/*a', to: 'application#not_found'
end
