Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  # }

  devise_for :users
  
  root to: redirect('settlements')

  get '/settlements', to: 'settlements#index'
  post '/settlements', to: 'settlements#create'

  patch '/settlements/:id', to: 'settlements#update'
  delete '/settlements/:id', to: 'settlements#destroy'

  get '/settlements/markdown/:id', to: 'settlements#markdown'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
