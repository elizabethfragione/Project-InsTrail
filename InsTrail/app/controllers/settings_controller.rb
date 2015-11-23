class SettingsController < ApplicationController
  def index
  end
  
  def set_settings
    
    if request.post? 

        

    end
    
    puts "POPULARITY:"
    puts setting
    
  end
  
  def create
    puts 'CREATE CALLED'
    @popularity = set_settings(popularity_params) 
    if @popularity.save 
      redirect_to '/settings' 
    else 
      puts 'else'
    end
  end
  
    def popularity_params
       params.require(:number)
    end
end
