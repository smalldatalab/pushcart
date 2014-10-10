FactoryGirl.define do
  factory :mission do
    name        { Faker::Lorem.sentence }
  end
end
