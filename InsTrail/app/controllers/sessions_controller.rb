class SessionsController < ApplicationController
	
	def create
	  #render text: request.env['omniauth.auth'].to_yaml
	  begin
	    puts 'SESSION CREATE! UY!'
	    @user = User.from_omniauth(request.env['omniauth.auth'])
	    puts 'FROM_OMNIAUTH RETURNS!'
	    puts 'USER ID IS'
	    puts @user.uid
	    session[:user_id] = @user.uid
	    #session[:user_id] = request.env['omniauth.auth']['uid']
	    flash[:success] = "Welcome, #{@user.nickname}!"
	  rescue
	    flash[:warning] = "There was an error while trying to authenticate you..."
	  end
	  redirect_to root_path
	  
	end

	def destroy
	  if current_user
	    session.delete(:user_id)
	    #flash[:success] = 'See you!'
	  end
	  redirect_to root_path
	end
end