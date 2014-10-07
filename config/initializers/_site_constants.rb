EMAIL_URI           = Rails.env.staging? ? 'sandbox.gopushcart.com' : 'lets.gopushcart.com'
SITE_NAME           = 'pushcart'
SITE_URL            = Rails.env.staging? ? 'sandbox.gopushcart.com' : 'gopushcart.com'
SECRET_KEY          = Rails.application.secrets.aes_secret_key
ASSETS_URL_ROOT     = 'https://s3.amazonaws.com/pushcart-assets/images'