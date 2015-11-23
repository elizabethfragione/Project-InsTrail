class Photo < ActiveRecord::Base
	belongs_to :trail
	
#	def initialize(trail_name,low_resolution_url,thumbnail_url,standard_resolution_url)
#		@trail_name = trail_name
#		@low_resolution_url = low_resolution_url
#		@thumbnail_url = thumbnail_url
#		@standard_resolution_url = standard_resolution_url
#	end

	def get_trail_name()
    @trail_name
  end
  
  def get_low_resolution_url()
    @low_resolution_url
  end
  
  def get_thumbnail_url()
    @thumbnail_url
  end
  
  def get_standard_resolution_url()
    @standard_resolution_url
  end
end
