require 'faker'

FactoryGirl.define do
  factory :user_identity do |f|
    f.username "1"
    f.password "password"
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
  end
end
