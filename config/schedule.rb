set :output, "#{path}/log/cron.log"

set :environment, ENV['RAILS_ENV']

# every :monday, at: '9:00 am' do
#   rake 'weekly_digester:mail_all_users'
# end