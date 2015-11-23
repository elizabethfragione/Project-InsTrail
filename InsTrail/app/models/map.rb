class Map < ActiveRecord::Base
  has_many :trails
  #might need to use after initialize
  def initialize (params = {})
    super
    @authenticated = params.fetch(:authenticated)
    @kind = params.fetch(:kind)
    @data = call_instagram
    @data_with_location = find_data_with_location(@data)
    trail_data = find_trail_and_counts(@data_with_location)
    self.update_attribute(:authenticated, @authenticated)
    self.update_attribute(:kind, @kind)
    
    if (@authenticated == true) 
      # here need to get a second set of data from autenticated user's media
    end
    
    # create trails for this map based on params, save in database? 

    # test of data is successfully fetched: puts trail_data 
    trail_data.each do |name, count| 
      @trail = self.trails.create({:name => name, :count => count, :user => false, :map_id => self.id})
    end
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
    while itr < CALLS
      new_data = Instagram.tag_recent_media(TAG, {:max_id => next_max_id})
      next_max_id = new_data.pagination.next_max_tag_id
      @data = @data + new_data
      itr = itr + 1
    end
    return @data
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
  
end
