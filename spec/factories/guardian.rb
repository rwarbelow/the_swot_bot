require 'faker'

FactoryGirl.define do
  factory :guardian do
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    preferred_language 'English'
  end
end
