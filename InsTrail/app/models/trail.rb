class Trail 
  @name 
  @latlon
  @count 
  # initialize trail with name, lat_long info and photo count
  def initialize(name, latlon, count)
    @name = name
    @latlon = latlon
  	@count = count
		
  end
  # getter for lat_lon
  def get_latlon
    @latlon
  end

  def get_lat
  	if !@latlon.nil?
  		@latlon[0]
  	end
  end

  def get_lon
  	if !@latlon.nil?
  		@latlon[1]
  	end
  end

  def get_name
    return @name
  end
    # getter for count
  def get_count
		@count
  end

end
