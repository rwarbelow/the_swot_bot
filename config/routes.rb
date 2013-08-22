SwotBot::Application.routes.draw do

  resources :identities


  namespace 'students' do
    resources :profiles
    resources :courses, :only => [:index, :show] do
      resources :assignments
      resources :submissions
      resources :grades
      get '/student_report', to: 'reports#student_report'
    end
    root :to => "dashboard#index"
  end

  namespace 'teachers' do
    get '/weekly_email', to: 'email#weekly_email'
    post '/send_student_email', to: 'email#send_student_email'
    resources :profiles do
      post '/add_phone_number', :to => 'profiles#add_phone_number'
      delete '/delete_phone_number', :to => 'profiles#delete_phone_number'
    end
    resources :student_profiles do
      get '/identities', :to => 'student_profiles#identity', as: :teacher_student_identity
    end
    resources :guardian_profiles
    get '/courseload', :to => 'courses#courseload'
    get '/livestream', :to => 'student_actions#index'
    scope 'livestream' do
      resources :student_actions
      get '/course_history/:id', :to => 'student_actions#course_history', as: :course_history_actions
    end
    resources :courses do
      get '/liveclass', :to => 'live#classroom'
      get '/roster', :to => 'courses#roster'
      resources :assignments
      resources :enrollments
      resources :submissions
      resources :grades
    end

    resources :assignments do
      resources :submissions
    end

    get '/student_report', to: 'reports#student_report'
    get '/report_search', to: 'reports#report_search'
    get '/course_report', to: 'reports#course'
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
  get '/student_report', to: 'reports#student_report'
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
