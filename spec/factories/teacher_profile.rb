require 'faker'

FactoryGirl.define do
  factory :teacher_profile do |f|
  	f.title { Faker::Lorem.word }
  	f.email { Faker::Internet.email }
  end
end
