require 'instagram'

@CLIENT_ID = '57ac5f94dbb843739de7985289247e19'
@CLIENT_SECRET = '518b732e84d2421488a011c3f47b86ea'
@ACCESS_TOKEN = '2234021065.57ac5f9.e5af7baef03c40ccbac3176085c895f5'

Instagram.configure do |config|
    config.client_id = @CLIENT_ID
    #config.client_secret = @@CLIENT_SECRET
    config.access_token = @ACCESS_TOKEN
end