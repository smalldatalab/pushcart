object @user

attributes :id,
           :household_size,
           :name

node(:mission) { |user| user.mission_id.nil? ? 'N/A' : user.mission.name }
node(:purchases_count) { |user| user.purchases.count }
node(:last_purchase_date) { |user| user.purchases.blank? ? nil : user.purchases.last.created_at  }
node(:last_activity_date) { |user| user.messages.blank? ? nil : user.messages.last.created_at }