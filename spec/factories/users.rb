FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    confirmed_at Time.now
    household_size 3

    trait :with_mission do
      mission
      mission_statement { Faker::Lorem.paragraph }
    end
  end
end
