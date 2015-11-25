class SettingsController < ApplicationController
  @setting

  def index
  	#@user = User.where(:nickname => 'semisezer')
    @setting = Setting.new
    @setting.number = DEFAULT
    if current_user 
    else
      flash[:notice] = "You need to be logged in to modify settings."
      redirect_to url_for(:controller => :map, :action => :index)
    end
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
    
    #@setting = current_user.setting.new
    current_user.setting.update_attribute(:number, number)
    #@setting.update_attribute(:number, number)
    #current_user.setting = @setting
    #puts Setting.first
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
end
