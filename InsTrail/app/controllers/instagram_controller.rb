class InstagramController < ApplicationController
  @@TAG = "vancouvertrails"
  @image_data = Array.new
  @@API_CALLS = 5
  
  def index
    instagram_api_call()
    # map functionality
    @test_trail = Trail.new(49.2827, -123.1139268)
    @trails = [@test_trail] 
      
    @hash = Gmaps4rails.build_markers(@trails) do |trail, marker|
      marker.lat trail.get_lat
      marker.lng trail.get_lon
      marker.infowindow "hello"
    end
  end

  def stubFilter
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
