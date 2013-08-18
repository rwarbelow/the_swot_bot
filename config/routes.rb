SwotBot::Application.routes.draw do
  
  resources :user_identities
 

  namespace :students do
    resources :student_profiles
    resources :courses, :only => [:index, :show] do
      resources :assignments
    end
    resources :submissions
    resources :grades
    root :to => "dashboard#index"
  end

  namespace :teachers do
    resources :teacher_profiles
    resources :courses do
      post :finals
    end
    resources :grades
    root :to => "dashboard#index"
  end


  namespace :guardians do
    resources :guardian_profiles do
      resources :guardianships, :only => [:index, :new, :create, :destroy]
    end
    root :to => "dashboard#index"
  end

  resources :messages
  
  get '/live_class', to: 'live#classroom'
  post '/live_class', to: 'students/student_actions#create'
  get '/error', to: 'home#909error', as: :error
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root :to => 'home#index'
end
