class MapController < ApplicationController
  @@map = nil
  
  def index
    if current_user
      @map = Map.create({:authenticated => true, :access_token => current_user.access_token, :user_id => current_user.id})
    else
      @map = Map.create({:authenticated => false, :access_token => 0, :user_id => 0})
    end
    @@map = @map
    addPinsToMap(Trail.where(user_id: 0))
  end
  
  
  def trail_photos
    @info = params[:info]
    puts "INFO EXPECTED BELOW"
    puts @info
    @info_space = @info.gsub!('+',' ')
    @selected_trail_photos = Trail.where(name: @info_space).first.photos
    @selected_trail_photos.each do |t|
      puts t.thumbnail_url
    end
    addPinsToMap(Trail.where(user_id: 0))
    render 'trail_photos'
  end

  
  def user_history
    if (not current_user)
	    flash.now[:notice] = "You need to be logged in to view your history."
      addPinsToMap(Trail.where(user_id: 0))
    else
      Map.destroy_all
      @map = Map.create({:authenticated => true, :user_id => current_user.id})
      trails = Trail.where(user_id: current_user.id)
      addPinsToMap(trails)
    end
    render 'index'
  end
  

  def top10
    trails = Trail.where(user_id: 0).limit(10).order('count desc')
    trails.each do |d|
      puts d[:name]
    end
    addPinsToMap(trails)
    render 'index'
  end
  
  def low10
    trails = Trail.where(user_id: 0).limit(10).order('count asc')
    trails.each do |d|
      puts d[:name]
    end
    addPinsToMap(trails)
    render 'index'
    
  end
  
  def popular 
    if current_user 
      setting = current_user.setting
      trails = Trail.where('count >= ?', setting.number).where(user_id: 0)
    else 
      trails = Trail.where('count >= ?', DEFAULT).where(user_id: 0)
    end
    addPinsToMap(trails)
    render 'index'
  end 
  
  def clear_filters
    trails = Trail.where(user_id: 0)
    addPinsToMap(trails)
    render 'index'
  end
  
  def refresh_map
    Trail.destroy_all
    Photo.destroy_all
    Map.destroy_all
    index
    render 'index'
  end
  
  def addPinsToMap(trails)
    @hash = Gmaps4rails.build_markers(trails) do |trail, marker|
      if !trail.nil?
        if !trail.lat.nil? && !trail.lon.nil?
          puts "_____________________________________________"
          marker.lat trail.lat
          puts "lat: " + trail.lat.to_s
          marker.lng trail.lon
          puts "lon: " + trail.lon.to_s
          marker.infowindow trail.name

          count_str = trail.count.to_s
          url_for_marker = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + count_str +'|FF0000|000000'
        
          marker.picture({
                      :url => url_for_marker,
                      :width  => 36,
                      :height => 36
                     })
        end
      end
    end
  end
  
end
