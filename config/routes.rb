SwotBot::Application.routes.draw do

  resources :user_identities


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
    resources :courses do
      resources :assignments
      resources :submissions
      resources :grades
    end
    root :to => "dashboard#index"
  end


  namespace 'guardians' do
    resources :profiles do
      post '/add_student', :to => 'add#student'
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
