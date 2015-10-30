require 'instagram'

@CLIENT_ID = '49316a6ab7b0475a8c45802e02a19143'
@CLIENT_SECRET = 'f39add31dd9c425f906aded8aba07800'
@ACCESS_TOKEN = '2257996576.cf0499d.08834443f30a4d278c28fcaf41af2f71'
@USER_ID = '2257996576'

Instagram.configure do |config|
    config.client_id = @CLIENT_ID
    #config.client_secret = @@CLIENT_SECRET
    config.access_token = @ACCESS_TOKEN
end