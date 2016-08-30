rm -rf ./tmp;
bundle install;
RAILS_ENV=production rake db:migrate;
rails server -e production --binding=0.0.0.0;
