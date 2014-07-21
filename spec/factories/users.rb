FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    confirmed_at Time.now

    trait :with_mission do
      mission
      mission_statement { Faker::Lorem.paragraph }
    end
  end
end
