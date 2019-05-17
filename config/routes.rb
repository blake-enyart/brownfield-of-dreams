Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  # Registration
  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/activation', to: 'activation#show', as: :activation_success

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  # Session
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  # OAuth
  get 'auth/github', as: 'github_login'
  get '/auth/:provider/callback', to: 'github_credentials#create'

  # User
  resources :users, only: [:new, :create, :update, :edit]
  get '/register', to: 'users#new'
  get '/users/:id', to: 'users#update', as: :activate_user
  get '/dashboard', to: 'users#show'
  
  # Friendship
  post '/friendship', to: 'friendships#create', as: :friendship
 
  resources :tutorials, only: [:show, :index]

  resources :user_videos, only: [:create]
end
