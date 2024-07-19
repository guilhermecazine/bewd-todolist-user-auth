# config/routes.rb
Rails.application.routes.draw do
  root 'homepage#index'

  resources :tasks, only: [:index, :create, :destroy] do
    collection do
      get :index_by_current_user
    end
    member do
      put :mark_complete
      put :mark_active
    end
  end

  # USERS
  post '/users' => 'users#create'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # SESSIONS
  post '/sessions' => 'sessions#create'
  get '/authenticated' => 'sessions#authenticated'
  delete '/sessions' => 'sessions#destroy'

  # Redirect all other paths to index page
  get '*path' => 'homepage#index'
end
