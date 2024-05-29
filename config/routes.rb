Rails.application.routes.draw do
  #
  # isolated domain, do not allow auth here
  #constraints host: 'localhost' do
  # GAMES
  get 'game/:user/:game/*path/:file', to: 'api/v1/games#play', constraints: { file: /[^\/]+/ }
  get 'game/:user/:game/:file', to: 'api/v1/games#play'
  #end

  namespace :api do
    namespace :v1 do

      #constraints host: "localhost" do
      # USERS
      get 'users/index', to: 'users#index'

      # GAMES
      post 'games', to: 'games#create'
      get 'games', to: 'games#index'
      #get 'games/:user/', to: 'games#show'
      #get 'games/:user/:game', to: 'games#show'
      get 'games_img/:user/:game', to: 'games#show_img'
      #resources :games

      # AUTH
      get 'auth/callback', to: 'auth#callback'
      get 'auth/data', to: 'auth#data'
      #end

    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
