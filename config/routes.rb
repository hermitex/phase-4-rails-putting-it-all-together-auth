Rails.application.routes.draw do
  post '/signup' => 'users#create'
  get '/me' => 'users#show'
  post "/login"  => "sessions#create"
  delete "/logout"  => "sessions#destroy"
  post "/recipes"  => "recipes#create"
  get "/recipes"  => "recipes#index"
end
