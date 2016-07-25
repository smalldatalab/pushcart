bundle install;
RAILS_ENV=development rake db:migrate;
rails server -e development --binding=0.0.0.0;
