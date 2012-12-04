Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '1970726135', '917e09c87ca64220e0a321c3d9fc3eb8'
end
