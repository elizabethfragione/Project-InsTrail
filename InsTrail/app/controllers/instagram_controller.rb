class InstagramController < ApplicationController
  @@TAG = "vancouvertrails"
  @image_data = Array.new
  @@API_CALLS = 20
  @@trail_names = Hash.new(0)
  @@list_of_trails = Array.new
  
  def index
    
    # returns to home page through the back-button of the browser should not make new instagram calls
    #if !initial_landing?
    #  return_home
    #  return
    #end
    update_recent_trail_info()
    
  end

  #calls instagram, updates trails
  def update_recent_trail_info
    instagram_api_call()
    @last_time_updated = Time.now
    countNames()
    createTrail
    addPinsToMap()
  end


  # called from the home button
  def return_home
    addPinsToMap()
    render :index
  end

  # called from refresh button
  def refresh_map
    update_recent_trail_info
    render :index
  end

  def initial_landing?
    @@list_of_trails.empty?
  end

  def addPinsToMap()
    @hash = Gmaps4rails.build_markers(@@list_of_trails) do |trail, marker|
      if !trail.nil?
        if !trail.get_latlon.nil?

          puts "_____________________________________________"
          marker.lat trail.get_lat
          puts "lat: " + trail.get_lat.to_s
          marker.lng trail.get_lon
          puts "lon: " + trail.get_lon.to_s
          marker.infowindow trail.get_name

          count_str = trail.get_count.to_s
          url_for_marker = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + count_str +'|FF0000|000000'
          
          marker.picture({
                      :url => url_for_marker,
                      #:url    => 'https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red' + trail.get_count.to_s + '.png',
                      #:picture => ActionController::Base.helpers.image_path("settings_logo.png"),
                      :width  => 36,
                      :height => 36
                     })
        end
      end
    end
  end

  
  def countNames()
    @image_data.each do |image|
      name = image.location.name
      @@trail_names[name] += 1
    end    
    #puts @@trail_names
  end

  def createTrail
    itr = 0
    @@trail_names.each do |name, count|
      t = Time.now
      if (itr == 10) 
        itr = 0
        puts "Have to time out"
        sleep (t + 2 - Time.now)
      else
        itr += 1
        puts itr
        lat_lon = Geocoder.coordinates(name)
        if !lat_lon.nil? && 48.931235 <= lat_lon[0] && lat_lon[0] <= 50.811827 && -128.530631 <= lat_lon[1] && lat_lon[1] <= -122.235670
          @trail = Trail.new(name, lat_lon, count)
          @@list_of_trails << @trail
          puts @trail.get_name()
        end
      end
    end
  end
  
  
  def instagram_api_call()
    # initial tag_recent_media
    @image_data = Instagram.tag_recent_media(@@TAG, {})
    next_max_id = @image_data.pagination.next_max_tag_id
    @image_data = filter_by_location(@image_data)
    
    # number of API calls for tag recent media
    @image_data = get_tag_recent_media(@@TAG, @image_data,next_max_id)
    perc_null_location = perc_null_location(@image_data)
    
    
  end
  
  def get_tag_recent_media(tag, image_data, next_max_id)
    iter = 0
    num_images = 0
    while iter < @@API_CALLS
      non_filtered_tag_media = Instagram.tag_recent_media(tag, {:max_id => next_max_id})
      next_max_id = non_filtered_tag_media.pagination.next_max_tag_id
      tag_media = filter_by_location(non_filtered_tag_media)
      image_data = image_data + tag_media
      
      num_images += tag_media.length
      iter = iter + 1
      print "Number of Images so far: "
      puts num_images
    end
    
    return image_data
  end
  
  def filter_by_location(non_filtered_tag_media)
    tag_media = Array.new
    non_filtered_tag_media.each do |image|
      unless image.location.nil?
        tag_media << image
      end
    end
    return tag_media
  end
  
  def perc_null_location(image_data)
    location_null_count = 0
    image_data.each do |image|
      if image.location.nil?
        location_null_count = location_null_count + 1
      end
    end
    perc_null_location = location_null_count.to_f / image_data.length
    print "% of NULL image locations: "
    puts perc_null_location
    return perc_null_location
  end
end
