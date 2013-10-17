require 'faker'

FactoryGirl.define do
  factory :identity do |f|
    f.sequence(:username) {|n| "user#{n}" }
    f.password "password"
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
  end
end
