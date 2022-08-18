Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users, only: [:create]           #handle signup
      post '/login', to: "auth#login"             #handles login for existing users
      get '/auto_login', to: 'auth#auto_login'    #handles auto login when user revisit the app

    end
  end
end
