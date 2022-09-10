Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  ENV['GOOGLE_CLIENT_ID'],
  ENV['GOOGLE_SECRET'],
  {
    provider_ignores_state: true,
    scope: 'userinfo.email, userinfo.profile',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }
end

OmniAuth.config.allowed_request_methods = %i[get]
