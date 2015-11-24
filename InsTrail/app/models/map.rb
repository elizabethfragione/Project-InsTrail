class Map < ActiveRecord::Base
  has_many :trails
  API_CALLS = 1
  attr_accessible :authenticated, :user_id
  #might need to use after initialize
  #def initialize(params = {})
  def initialize (params = {}, kind)
    authenticated = params.fetch(:authenticated)
    
    

    puts 'AUTHENTICATED VALUE = ' + authenticated.to_s

    super
    puts 'AUTHENTICATED VALUE = ' + authenticated.to_s

    #@authenticated = params.fetch(:authenticated)
    #@kind = kind



    @data = call_instagram
    @data_with_location = find_data_with_location(@data)
    trail_data = find_trail_and_counts(@data_with_location)
    self.update_attribute(:authenticated, authenticated)
    #self.update_attribute(:kind, @kind)
    #self.authenticated = true
    # make sure to erase user trails everytime logged out 
    if (authenticated == true) 
      user_id = params.fetch(:user_id)
      puts 'INSTAGRAM API USER CALL'
      puts 'ACCESS TOKEN IS'
      self.user_id = user_id

      #puts current_session[:access_token]
      @user_data = call_instagram_user
      
      @user_data_with_location = find_data_with_location(@user_data)
      user_trail_data = find_trail_and_counts(@user_data_with_location)
      @user_trails = create_trails(user_trail_data, authenticated)
    end
    # MOVE TRAIL CREATIIONG into MapController
    @trails = create_trails(trail_data, authenticated)
    return self
  end
  
  # Make Instagram API call(s) to Instagram to get elements for map object  
  # input: tag to search, number of API calls 
  # output: array of image data (Hashie Mesh form)
  def call_instagram
    itr = 0
    @data = Array.new
    @data = Instagram.tag_recent_media(TAG, {})
    next_max_id = @data.pagination.next_max_tag_id
    itr = itr + 1
    
    while itr < API_CALLS
      new_data = Instagram.tag_recent_media(TAG, {:max_id => next_max_id})
      next_max_id = new_data.pagination.next_max_tag_id
      @data = @data + new_data
      itr = itr + 1
    end
    return @data
  end

    def call_instagram_user
      puts 'INSIDE INSTAGRAM USER'
      itr = 0
      user = User.find_by(id: self.user_id)
      #user_id = session[:user_id]
      #user = User.find_by(id: user_id)
      @user_data = Array.new
      client = Instagram.client({:access_token => user.access_token})
      @user_data = client.user_recent_media
      # TODO: filter out tags
      next_max_id = @user_data.pagination.next_max_user_id
      itr = itr + 1
      
      while itr < API_CALLS
        new_data = Instagram.user_recent_media(TAG, {:max_id => next_max_id})
        next_max_id = new_data.pagination.next_max_user_id
        @user_data = @user_data + new_data
        itr = itr + 1
      end
      return @user_data
  end
  
  # Filter elements to find those with location information
  # input: output from Instagram API calls
  def find_data_with_location(all_data)
    @data_with_location = Array.new
    all_data.each do |image|
      unless image.location.nil?
        @data_with_location << image
      end
    end
    return @data_with_location
  end
  
  # Extract trails and their counts from data with location
  # input: output from find_data_with_location
  def find_trail_and_counts(data_with_location)
    trail_data = Hash.new(0)
    data_with_location.each do |image|
      name = image.location.name
      trail_data[name] += 1
    end    
    return trail_data
  end
  
  def create_trails(trail_data, authenticated)
    itr = 0
    trail_data.each do |trail_name, photo_count|
      t = Time.now
      if (itr == 10) 
        itr = 0
        puts "Have to time out"
        sleep (t + 1.5 - Time.now)
      else
        itr += 1
        puts itr
        lat_lon = Geocoder.coordinates(trail_name)
        if !lat_lon.nil? && in_vancouver(lat_lon)
          puts "************************* TRAIL NAME ******************"
          puts trail_name
          begin
            @trail = self.trails.create(:name => trail_name, :user => authenticated, :lat => lat_lon[0], :lon => lat_lon[1], :count => photo_count)
          rescue
            @trail = Trail.where(name: trail_name)
          end
          create_photos(@trail)
        end
      end
    end
    return @trails
  end
    
  def create_photos(trail)
    trail_name = @trail.name
    photos_hash = Array.new
    photos = Array.new
    @data_with_location.each do |img|
      if trail_name == img.location.name
        photos_hash << img
      end 
    end
    photos_hash.each do |img|
      location = img.location
      puts location
      low_resolution_url = img.images.low_resolution.url
      thumbnail_url = img.images.thumbnail.url
      standard_resolution_url = img.images.standard_resolution.url
      pid = img.images.id
      begin
        @photo = trail.photos.create(:pid => pid, :trail_name => trail_name,:low_resolution_url => low_resolution_url,:thumbnail_url => thumbnail_url,:standard_resolution_url => standard_resolution_url)
      rescue
        @photo = Photo.where(pid: pid)
      end
    end
  end
  
  def in_vancouver(lat_lon)
    return (48.931235 <= lat_lon[0] && lat_lon[0] <= 50.811827 && -128.530631 <= lat_lon[1] && lat_lon[1] <= -122.235670)
  end

  
end
