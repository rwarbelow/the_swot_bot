SwotBot::Application.routes.draw do
  
  resources :user_identities
 
  scope :constraints => lambda{ |req| req.session[:session_user_type] == :StudentProfile } do
    scope module: "students" do
      resources :student_profiles do
        resource :courses, :only => [:index, :show]
      end
      root :to => "dashboard#index"
    end
  end

  scope :constraints => lambda{ |req| req.session[:session_user_type] == :TeacherProfile } do
    scope module: "teachers" do
      resources :teacher_profiles do
        resources :courses
      end
    end
  end
  
  scope :constraints => lambda{ |req| req.session[:session_user_type] == :GuardianProfile } do
    scope module: "guardians" do
      resources :guardian_profiles do
        # post :add_student, :on => :member
        resources :guardianships
      end
    end
  end

  
  post '/guardians/guardian_profiles/:guardian_profile_id/add_student', to: 'guardians/guardian_profiles#add_student', as: :add_student
  get '/live_class', to: 'live#classroom'
  post '/live_class', to: 'students/student_actions#create'
  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'home#index'
end
