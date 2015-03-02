Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
            Rails.application.secrets.google_client_id,
            Rails.application.secrets.google_secret,
            {
              scope: 'email profile gmail.readonly',
              prompt: 'consent select_account',
              access_type: 'offline',
              image_aspect_ratio: 'square',
              image_size: 50
            }
end