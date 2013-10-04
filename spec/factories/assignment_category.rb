FactoryGirl.define do
  factory :assignment_category do
    name { Faker::Lorem.sentence(3) }
    weight { rand(1..9) / 10.0 }
    course
  end
end
