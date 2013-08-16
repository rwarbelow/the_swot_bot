require 'faker'

FactoryGirl.define do
  factory :teacher_profile do |f|
  	f.title { Faker::Lorem.word }
  	f.email { Faker::Internet.email }
  	f.cell_phone_number { Faker::PhoneNumber.cell_phone }
  end
end
