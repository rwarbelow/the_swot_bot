require 'faker'

FactoryGirl.define do
  factory :subject do
    name { Faker::Lorem.word }
  end
end
