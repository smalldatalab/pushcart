if Rails.env.development? || Rails.env.test?
  ActionMailer::Base.smtp_settings = {
    :address        => 'localhost',
    :port           => 1025
  }
else
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.mandrillapp.com',
    :port           => '587',
    :authentication => :plain,
    :user_name      => Rails.application.secrets.mandrill_username,
    :password       => Rails.application.secrets.mandrill_password,
    :domain         => SITE_URL,
    :enable_starttls_auto => true
  }
end

# ActionMailer::Base.default_url_options[:host] = BASE_URL
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) unless Rails.env.production?