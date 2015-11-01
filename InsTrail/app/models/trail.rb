class Trail 
  @name 
  @latlong
  @count 
  # initialize trail with name, lat_long info and photo count
  def initialize(name, latlong, count)
    @name = name
    @latlong = latlong
  	@count = count
		
  end
  # getter for lat_long
  def get_latlon
    @latlong
  end

  def get_lat
  	if !@latlong.nil?
  		@latlong[0]
  	end
  end

  def get_lon
  	if !@latlong.nil?
  		@latlong[1]
  	end
  end

  # getter for count
  def get_count
		@count
  end

end
