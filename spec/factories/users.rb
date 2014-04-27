FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    confirmed_at Time.now
    household_size 3
  end
end
