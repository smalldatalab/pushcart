FactoryGirl.define do
  factory :user do
    email 'me@my-email.com'
    confirmed_at Time.now
    endpoint_email 'celestial-snowflake-outrageous-temple'
    household_size 3
  end
end
