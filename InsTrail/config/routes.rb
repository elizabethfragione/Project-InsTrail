Rails.application.routes.draw do
  # Assuem: 
  # button 1 = Setting 
  # button 2 = Top 20 
  # button 3 = Popular 
  # button 4 = Your trails 
  # button 5 = Clear filter
  root 'map#index'
  get "/refresh_map" => "map#refresh_map"
  post "/refresh_map" => "map#refresh_map"
  # post "/refresh_map" => "instagram#refresh_map"
  # different filtered maps: show needs to filter? 
  get "/map/:id" => "map#show", as: :filtered_map
  get "/about" => "about#index"
  get "/setting" => "setting#index"
  
  get "/history" => "map#history"
  post "/history" => "map#history"
  
  get "/top_10" => "map#top_10"
end
