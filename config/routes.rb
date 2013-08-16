SwotBot::Application.routes.draw do
  resources :user_identities
  resources :student_profiles
  resources :teacher_profiles
  resources :guardian_profiles

  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'home#index'
end
