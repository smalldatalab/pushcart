require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Pushcart
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/email_scrapers)

    config.time_zone = 'Eastern Time (US & Canada)'

    config.encoding = "utf-8"

    config.assets.precompile += ['homepage_meta.js']

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # CORS implementation
    config.middleware.insert_before Warden::Manager, Rack::Cors do
      allow do
        origins '*'
        # resource '/oauth/token', headers: :any, methods: [:post]
        resource '*', headers: :any, methods: [:post, :get]
      end
    end
  end
end
