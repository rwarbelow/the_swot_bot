require 'faker'

FactoryGirl.define do
  factory :student_profile do |f|
  	f.gender ["f", "m"].sample
  	f.birthday "3/4/2008"
  	f.address { Faker::Address.street_address }
  	f.ccsd_id ((0..9).to_a).shuffle[0,7].join
  	f.grade_level { Faker::Lorem.word }
  	f.email { Faker::Internet.email }
  	f.cell_phone_number { Faker::PhoneNumber.cell_phone }
  end
end
