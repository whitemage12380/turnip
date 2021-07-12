Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  # }

  devise_for :users
  
  root to: 'settlements#index'

  get '/settlements', to: 'settlements#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
