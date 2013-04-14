PushMePullYou::Application.routes.draw do

  root :to => 'user_sessions#new'

  get     'login'   => 'user_sessions#new',     :as => :login
  post    'login'   => 'user_sessions#create'
  delete  'logout'  => 'user_sessions#destroy', :as => :logout

  get   'signup' => 'users#new', :as => :signup
  post  'signup' => 'users#create'

  resources :users do
    member do
      post :add_all_stories
    end
  end
  resources :stories do
    resources :tasks, :except => [:show, :index]
    member do
      post :push
    end
  end

end
