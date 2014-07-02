source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.1'

gem 'thin'

gem 'pg'

### E-mail receipt & scraping ###

gem 'griddler'
gem 'nokogiri'
gem 'nokogiri-styles'

### API ###

gem 'json'
gem 'rabl'
gem 'oj'
gem 'versionist'
gem 'rack-cors'

### Authentication ###

gem 'devise'
gem 'simple_token_authentication' #Auto-login tokens
gem 'doorkeeper'
gem 'bazaar'

### Assets ###

gem 'turbolinks'
gem 'haml'
gem 'sass-rails',       '~> 4.0.2'
gem 'coffee-rails',     '~> 4.0.1'
gem 'jquery-rails'
gem 'uglifier',         '>= 1.3.0'
gem 'foundation-rails'
gem 'foundation-icons-sass-rails', '3.0.0'

### Forms ###

gem 'simple_form',      '~> 3.1.0.rc1'
gem 'nested_form'

### Background Processes ###

gem 'foreman',                   '~> 0.63.0'
gem 'delayed_job_active_record'
gem 'whenever',                  require: false

### External APIs ###

# gem 'nutritionix' #This gem sucks and is totally broken

### Admin ###
gem 'activeadmin',  github: 'gregbell/active_admin' #Move to specific version once a stable Rails 4 gem is on rubygems
gem 'country_select'
gem 'polyamorous',  github: 'activerecord-hackery/polyamorous'
gem 'ransack',      github: 'activerecord-hackery/ransack', branch: 'rails-4.1'
gem 'formtastic',   github: 'justinfrench/formtastic'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano',    '~> 2.15.5'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'mailcatcher' # for viewing test messages in the browser @ http://localhost:1080/
  gem 'quiet_assets' # shut up asset logs
  gem 'minitest'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'mocha', require: 'mocha/api'
  gem 'shoulda'
  gem 'json_spec'
  gem 'email_spec'
  gem 'simplecov', '~> 0.7.1', require: false
  gem 'pry'
  gem 'database_cleaner'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
