object @user

attributes :id,
           :household_size

node(:purchase_count) { |user| user.purchases.count }
node(:alias) { |user| user.endpoint_email }