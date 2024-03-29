class User < ActiveRecord::Base
	@user
	attr_accessible :nickname, :image_url, :provider, :uid, :access_token, :setting
  has_one :setting

	def self.from_omniauth(auth_hash)
	  	puts 'USER FROM_OMNIAUTH !UY!'
	    @user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
	    puts auth_hash['uid']
	    puts auth_hash['provider']
	    @user.nickname = auth_hash['info']['nickname']
	    @user.image_url = auth_hash['info']['image']
	    @user.access_token = auth_hash['credentials']['token']
      @setting = Setting.new
      @setting.update_attribute(:number, DEFAULT)
      @user.setting = @setting
	    @user.save!
	    @user
    end

    def self.get_user
    	uid = current_user.uid
    	provider = current_user.provider

    	@user = find_or_create_by(uid, provider)
    end

    
    #if auth_hash['info']
    #	user.name = auth_hash['info']['name'] || "empty name"
    #	user.image_url = auth_hash['info']['image'] || "empty image_url"
    #end

    #puts user.name
    #puts user.image_url
    #user.save!
    #user
  #end
end