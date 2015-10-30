class Photo < ActiveRecord::Base
	def init(t_name, t_location, p_location )
		@trail_name = t_name
		@trail_location = t_location
		@photo_location = p_location
	end

	def get_trail_name()
		@trail_name
	end

	def get_trail_location()
		@trail_location
	end
	
	def get_photo_location()
		@trail_location
	end


end
