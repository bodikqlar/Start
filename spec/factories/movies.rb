require 'faker'
FactoryGirl.define do
  factory :movie do
    user
    name Faker::Name.title
    rating {rand(1..5)}
  end
end
