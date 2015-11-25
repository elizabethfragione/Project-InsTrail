Rails.application.routes.draw do
  root to: 'map#index'
  
  #get "/index" => "map#index"
  get "/index" => "map#clear_filters"
  post "/index" => "map#clear_filters"
  
  get "/refresh_map" => "map#refresh_map"
  post "/refresh_map" => "map#refresh_map"
  
  post "/user_history" => "map#user_history"
  get "/user_history" => "map#user_history"
  
  get "/about" => "about#index"
  
  get "/settings" => "settings#index"
  post "/settings" => 'settings#update'
  
  get "/low10" => "map#low10"
  post "/low10" => "map#low10"
  
  get "/top10" => "map#top10"
  post "/top10" => "map#top10"
  
  get "/popular" => "map#popular"
  post "popular" => "map#popular"
  
  get "/filters" => "map#clear_filters"
  post "/filters" => "map#clear_filters"
  
  get "/about" => "about#index"

#  post "/settings/" => "settings#set_settings"
  get "/trail_photos/:info" => "map#trail_photos"
  post "/trail_photos/:info" => "map#trail_photos"
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'map#index'
  delete '/logout', to: 'sessions#destroy'


  resources :users
  resources :settings

end
