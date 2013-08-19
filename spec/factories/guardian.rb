require 'faker'

FactoryGirl.define do
  factory :guardian do |f|
    f.guardian_role "1"
    f.address { Faker::Address.street_address }
    f.email { Faker::Internet.email }
  end
end
