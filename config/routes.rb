Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/index', to: 'users#index'
      #get 'users/new'
      #get 'users/create'
      #get 'users/delete'
      get 'blogs/index', to: 'blog#index'
      post 'blogs/create', to: 'blog#create'
      get '/show/:id', to: 'blog#show'
      delete '/destroy/:id', to: 'blog#destroy'

      get 'auth/callback', to: 'auth#callback'
      get 'auth/data', to: 'auth#data'
    end
  end
  root 'homepage#index'
  #get '/*path' => 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
