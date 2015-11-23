class MapController < ApplicationController
  @@map = nil
  def index
    @map = Map.create({:authenticated => false, :kind => "default"})
    @@map = @map 
  end
  
  def refresh_map
    puts @@map[:authenticated]
    render 'index'
  end
  
  # fix double-creating map
  
  def history
    value = @@map[:authenticated]
    if (value == false)
      #have a flash method
      render 'index'
    else
      #render only trails that are in user history
      trails = Trail.where('user = ?', params[true])
    end
  end
  
  # get top 10 public trails by biggest count 
  def top_10
    trails = Trail.where(user: false).where('map_id = 1').limit(10).order('count desc')
    trails.each do |d|
      puts d[:name]
    end
  end
  
  # get all trails with count exceeding setting
  def popular
    #:thresold = Popularity.customized_setting
    #trails = Trail.where('count >= ?', params[:thresold])
  end
end
