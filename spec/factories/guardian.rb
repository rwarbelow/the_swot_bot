require 'faker'

FactoryGirl.define do
  factory :guardian do |f|
    f.guardian_role "1"
    f.address { Faker::Address.street_address }
    f.email { Faker::Internet.email }
    f.cell_phone_number { Faker::PhoneNumber.cell_phone }
    f.work_phone_number { Faker::PhoneNumber.cell_phone }
  end
end
