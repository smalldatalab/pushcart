object @user

attributes :id,
           :household_size

node(:alias) { |user| user.endpoint_email }