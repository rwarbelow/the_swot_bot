SwotBot::Application.routes.draw do


  namespace 'students' do
    resources :goals do
      post '/complete', to: 'goals#complete'
    end
    resources :courses, :only => [:index, :show] do
      resources :assignments, :only => [:show]
      resources :submissions
      resources :grades
      get '/student_report', to: 'reports#student_report'
    end
    get 'profile',      to: 'profiles#show',   :as => :profile
    get 'profile/edit', to: 'profiles#edit',   :as => :edit_profile
    put 'profile',      to: 'profiles#update', :as => :update_profile
    root :to => "dashboard#index"
  end

  namespace 'teachers' do
    get 'daily_summary', to: 'dashboard#daily_summary'
    get 'scholar_hour_enrollment', to: 'scholar_hours#generate_scholar_hour_list'
    get '/weekly_email', to: 'email#weekly_email'
    post '/send_student_email', to: 'email#send_student_email'
    resources :scholar_hours
    resources :profiles do
      post '/add_phone_number', :to => 'profiles#add_phone_number'
      delete '/delete_phone_number', :to => 'profiles#delete_phone_number'
    end
    resources :student_profiles do
      get '/identities', :to => 'student_profiles#identity', as: :teacher_student_identity
      get '/course_overview/:course_id', :to => 'student_profiles#course_overview', as: :course_overview
    end
    resources :guardian_profiles
    get '/courseload', :to => 'courses#courseload'
    get '/livestream', :to => 'student_actions#index'
    scope 'livestream' do
      resources :student_actions
      get '/course_history/:id', :to => 'student_actions#course_history', as: :course_history_actions
    end
    resources :courses do
      get '/student_record/:student_id', :to => 'courses#student_record', as: :student_record
      get '/liveclass', :to => 'live#classroom'
      get '/roster', :to => 'courses#roster'
      resources :assignments
      resources :assignment_categories
      post '/update_categories', :to => 'assignment_categories#update_all'
      resources :enrollments
      resources :submissions
      resources :grades
    end
    resources :announcements
    resources :assignments do
      resources :submissions
    end

    get '/student_report', to: 'reports#student_report'
    get '/report_search', to: 'reports#report_search'
    get '/course_report', to: 'reports#course'
    root :to => "dashboard#index"
  end

  namespace 'guardians' do
    post '/update_identity/:identity_id', :to => 'profiles#update_identity'
    resources :profiles do
      post '/add_student', :to => 'profiles#add_student'
      post '/add_phone_number', :to => 'profiles#add_phone_number'
      delete '/delete_phone_number', :to => 'profiles#delete_phone_number'
    end
  resources :students, only: [:show] do
    resources :courses
  end
  get '/student_report', to: 'reports#student_report'
  root :to => "dashboard#index"
end

 namespace 'admin' do
  resources :identities
  resources :guardian_profiles
  resources :student_profiles
  resources :teacher_profiles
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

root :to => 'sessions#new'
end
