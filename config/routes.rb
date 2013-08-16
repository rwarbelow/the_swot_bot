SwotBot::Application.routes.draw do
  
  resources :user_identities
 
  scope module: "students" do
    resources :student_profiles, module: 'students'
  end
  
  scope "teachers" do
    resources :teacher_profiles, module: 'teachers'
  end
  
  scope "guardians" do
    resources :guardian_profiles, module: 'guardians'
  end

  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'home#index'
end
