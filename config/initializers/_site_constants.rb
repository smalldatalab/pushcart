ENABLE_NUTRITIONIX = Rails.env.test? ? false : true

EMAIL_URI           = Rails.env.staging? ? 'sandbox.gopushcart.com' : 'lets.gopushcart.com'
SITE_NAME           = 'pushcart'
SITE_URL            = Rails.env.staging? ? 'sandbox.gopushcart.com' : 'gopushcart.com'
SECRET_KEY          = Rails.application.secrets.aes_secret_key
ASSETS_URL_ROOT     = 'https://s3.amazonaws.com/pushcart-assets/images'

#Gmail API setup

require 'google/api_client'

GMAIL_CLIENT        = Google::APIClient.new(
                                              application_name: Rails.application.secrets.google_app_name,
                                              application_version: '1.0'
                                            )


GMAIL_CLIENT.authorization.client_id     = Rails.application.secrets.google_client_id
GMAIL_CLIENT.authorization.client_secret = Rails.application.secrets.google_secret