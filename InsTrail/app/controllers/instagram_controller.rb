class InstagramController < ApplicationController
  @user_id = 2234021065
  def index
    @recent_media = Instagram.user_recent_media(@user_id, {:count => 1})
    @popular = Instagram.media_popular
  end
end
