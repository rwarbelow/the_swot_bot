SwotBot::Application.routes.draw do
  resources :user_identity

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'home#index'
end
