class User < ActiveRecord::Base
	attr_accessible :nickname, :image_url, :provider, :uid

	def self.from_omniauth(auth_hash)
	  	puts 'USER FROM_OMNIAUTH !UY!'
	    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
	    puts auth_hash['uid']
	    puts auth_hash['provider']
	    user.nickname = auth_hash['info']['nickname']
	    user.image_url = auth_hash['info']['image']
	    user.access_token = auth_hash['credentials']['token']

	    user.save!
	    user
	    #user.name = auth_hash['info']['name'] || "empty name"
	    
	    #puts 'NICK NAME'
	    #puts auth_hash['info']['nickname']
	    #puts 'IMAGE_URL'
	    #puts auth_hash['info']['image']
	    #puts 'ACCESS_TOKEN'
	    #puts auth_hash['credentials']['token']
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