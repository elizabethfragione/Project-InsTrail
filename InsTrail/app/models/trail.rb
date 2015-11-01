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
  def get_latlong
    return @latlong
  end
  # getter for count
	def get_count
		return @count
	end

end
