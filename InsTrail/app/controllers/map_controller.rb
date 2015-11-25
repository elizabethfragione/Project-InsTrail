class MapController < ApplicationController
  @@map = nil
  def index
    puts "************INSIDE INDEX*****************"
    puts CALLS
    if current_user
      #@map = Map.create(:authenticated => true, :kind => "default")
      puts 'INSIDE INDEX CURRENT USER IN MAPS CONTROLLER'
      @map = Map.create({:authenticated => true, :access_token => current_user.access_token, :user_id => current_user.id})
    else
      puts 'INSIDE INDEX NOT CURRENT USER IN MAPS CONTROLLER'
      @map = Map.create({:authenticated => false, :access_token => 0, :user_id => 0})
    end
    @@map = @map
    #@map.create_trails
    addPinsToMap(Trail.where(user_id: 0))
  end
  
  def user_history
    #authenticated = @map[:authenticated]
    puts '**** INSIDE HISTORY **** '
    puts current_user
    authenticated = current_user
    puts current_user

    if (not current_user)
      puts '**** NOT AUTHENTICATED **** '
	    flash.now[:notice] = "You need to be logged in to view your history."
      addPinsToMap(Trail.where(user_id: 0))
    
    else
      puts '**** AUTHENTICATED **** '
      Map.destroy_all
      puts 'PRINT CURRENT USER BELOW'
      puts current_user
      @map = Map.create({:authenticated => true, :user_id => current_user.id})
      #@map = Map.create(:authenticaed => true, :kind => "default")
      trails = Trail.where(user_id: current_user.id)
      #removePinsFromMap
      addPinsToMap(trails)
    end
    render 'index'
  end
  
  # get top 10 public trails by biggest count 
  def top10
    trails = Trail.where(user_id: 0).where('map_id = 1').limit(10).order('count desc')
    trails.each do |d|
      puts d[:name]
    end
    #removePinsFromMap
    addPinsToMap(trails)
    render 'index'
    
  end
  
  def low10
    trails = Trail.where(user_id: 0).where('map_id = 1').limit(10).order('count asc')
    trails.each do |d|
      puts d[:name]
    end
    #removePinsFromMap
    addPinsToMap(trails)
    render 'index'
    
  end
  
  def popular 
    if current_user 
      setting = current_user.setting
      trails = Trail.where('count >= ?', setting.number).where(user_id: 0)
    else 
      puts DEFAULT
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
  
  def return_home
    #redirect_to clear_filters
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
