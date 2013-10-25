require 'faker'

FactoryGirl.define do
  factory :teacher do
    title { Faker::Lorem.word }
    email { Faker::Internet.email }
    identity
  end
end
