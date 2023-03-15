Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/login', to: 'auth#create'
  post "/signup", to: "users#create"
  post '/autologin', to: 'auth#autologin'

  get '/logged_in', to: 'auth#logged_in?'

end
