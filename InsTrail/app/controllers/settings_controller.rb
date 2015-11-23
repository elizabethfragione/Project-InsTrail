class SettingsController < ApplicationController
  @setting

  def index
  	#@user = User.where(:nickname => 'semisezer')
  	@setting = Setting.create
  	@setting.number = 5
  	
  end

  def set_settings
    @setting.popularity = 10
    if request.post? 

    end
    
    puts "POPULARITY:"
    puts setting
    
  end


  def update
  	puts 'UPDATE CALLED!'
  	puts setting_params[:number]
  	number = setting_params[:number]
  	puts 'SETTING DOWN HERE!'
  	puts @setting
  	#@setting.update_attribute(:number, number)
  	#puts @setting[:number]
  	flash[:success] = "Popularity updated to: #{number}"
  	redirect_to "/settings/"

  	#@setting.number = setting_params
  end

  private
  def setting_params
  	params.require(:setting)
  end
  def update 
  end
end
