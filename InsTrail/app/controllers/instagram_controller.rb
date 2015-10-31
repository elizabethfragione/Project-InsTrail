class InstagramController < ApplicationController
  @user_id = 2234021065
  def index
    @recent_media = Instagram.user_recent_media(@user_id, {:count => 1})
    @popular = Instagram.media_popular

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
end
