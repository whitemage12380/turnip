Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  # }

  devise_for :users
  
  root to: 'settlements#index'

  get '/settlements', to: 'settlements#index'
  post '/settlements', to: 'settlements#create'

  patch '/settlement/:id', to: 'settlements#update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
