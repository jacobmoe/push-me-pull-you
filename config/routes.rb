PushMePullYou::Application.routes.draw do

  root :to => 'user_sessions#new'

  get     'login'   => 'user_sessions#new',     :as => :login
  post    'login'   => 'user_sessions#create'
  delete  'logout'  => 'user_sessions#destroy', :as => :logout

  get   'signup' => 'users#new', :as => :signup
  post  'signup' => 'users#create'

  resources :users
  resources :stories do
    resources :tasks, :except => [:show, :index]
  end

end
