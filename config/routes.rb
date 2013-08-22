SwotBot::Application.routes.draw do

  resources :identities


  namespace 'students' do
    resources :profiles
    resources :courses, :only => [:index, :show] do
      resources :assignments
      resources :submissions
      resources :grades
    end
    root :to => "dashboard#index"
  end

  namespace 'teachers' do
    resources :profiles
    resources :student_profiles do
      get '/identities', :to => 'student_profiles#identity', as: :teacher_student_identity
    end
    resources :guardian_profiles
    resources :courses do
      get '/liveclass', :to => 'live#classroom'
      resources :assignments
      resources :enrollments
      resources :submissions
      get '/student_report', to: 'reports#student_report'
      get '/report_search', to: 'reports#report_search'
      get '/course_report', to: 'reports#course'
      resources :grades
    end
    
    resources :assignments do
      resources :submissions
    end
    
    root :to => "dashboard#index"
  end

  namespace 'guardians' do
    resources :profiles do
      post '/add_student', :to => 'profiles#add_student'
      post '/add_phone_number', :to => 'profiles#add_phone_number'
      delete '/delete_phone_number', :to => 'profiles#delete_phone_number'
    end
    resources :students do
      resources :courses
    end
    root :to => "dashboard#index"
  end

  resources :messages
  get '/received_message/:id', :to => 'messages#show_received', :as => 'show_received'
  get '/sent_message/:id', :to => 'messages#show_sent', :as => 'show_sent'

  
  post "/callbacks/cloud_elements", to: "callbacks#cloud_elements"
  get '/live_class', to: 'live#classroom'
  post '/live_class', to: 'teachers/live#create_action'
  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root :to => 'home#index'
end
