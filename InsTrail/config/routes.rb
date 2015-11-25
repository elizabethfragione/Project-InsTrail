Rails.application.routes.draw do
  root to: 'map#index'
  
  get "/index" => "map#index"
  get "/refresh_map" => "map#refresh_map"
  post "/refresh_map" => "map#refresh_map"
  post "/user_history" => "map#user_history"
  get "/user_history" => "map#user_history"
  get "/about" => "about#index"
  get "/settings" => "settings#index"
  post '/settings/' => 'settings#update'
  post "/low10" => "map#low10"
  post "/top10" => "map#top10"
  post "/filters" => "map#clear_filters"
  get "/about" => "about#index"
  get "/settings" => "settings#index"

  post "/settings/" => "settings#set_settings"
  get "/trail_photos/:info" => "map#trail_photos"
  post "/trail_photos/:info" => "map#trail_photos"
  

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'map#index'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :settings

end
