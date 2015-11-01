class Trail < ActiveRecord::Base
	def initialize(lattitude, longitude)
		@lat = lattitude
		@lon = longitude
		@count = 1
		
	end

	def get_lat()
		@lat
	end

	def get_lon()
		@lon
	end

	def get_count()
		@count
	end

end
