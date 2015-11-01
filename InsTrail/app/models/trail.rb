class Trail < ActiveRecord::Base
	def initialize(lattitude, longitude)
		@lat = lattitude
		@lon = longitude
		
	end

	def get_lat()
		@lat
	end

	def get_lon()
		@lon
	end

end
