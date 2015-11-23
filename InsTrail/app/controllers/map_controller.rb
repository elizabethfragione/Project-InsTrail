class MapController < ApplicationController
  @@map = nil
  def index
    if current_user
      @map = Map.create({:authenticated => true, :kind => "default"})
    else
      @map = Map.create({:authenticated => false, :kind => "default"})
    end
    @@map = @map
    addPinsToMap(Trail.where(user: false))
  end
  
  def refresh_map
    puts @@map[:authenticated]
    render 'index'
  end
  
  # fix double-creating map
  
  def history
    authenticated = @@map[:authenticated]
    if (authenticated == false)
	    flash[:success] = "Welcome, #{current_user.nickname}!"
      render 'index'
    else
      trails = Trail.where('user = ?', params[true])
      #removePinsFromMap
      addPinsToMap(trails)
    end
  end
  
  # get top 10 public trails by biggest count 
  def top10
    trails = Trail.where(user: false).where('map_id = 1').limit(10).order('count desc')
    trails.each do |d|
      puts d[:name]
    end
    #removePinsFromMap
    addPinsToMap(trails)
    render 'index'
    
  end
  
  def low10
    trails = Trail.where(user: false).where('map_id = 1').limit(10).order('count asc')
    trails.each do |d|
      puts d[:name]
    end
    #removePinsFromMap
    addPinsToMap(trails)
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
  
  
end
