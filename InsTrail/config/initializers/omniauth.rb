Rails.application.config.middleware.use OmniAuth::Builder do
	provider :instagram, '49316a6ab7b0475a8c45802e02a19143', 'f39add31dd9c425f906aded8aba07800'
end