FactoryGirl.define do
  factory :mission do
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
