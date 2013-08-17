SwotBot::Application.routes.draw do
  
  resources :user_identities
 
  scope "students" do
    resources :student_profiles, module: 'students' do
      resources :reports
    end
  end
  
  scope "teachers" do
    resources :teacher_profiles, module: 'teachers'
  end
  
  scope "guardians" do
    resources :guardian_profiles, module: 'guardians' do
      resources :guardianships
    end
  end

  
  post '/guardians/guardian_profiles/:guardian_profile_id/add_student', to: 'guardians/guardian_profiles#add_student', as: :add_student
  get '/live_class', to: 'live#classroom'
  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'home#index'
end
