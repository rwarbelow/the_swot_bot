require 'faker'

FactoryGirl.define do
  factory :assignment do
    course
    title { Faker::Lorem.sentence(rand(1..5)) }
    description { Faker::Lorem.sentences(rand(1..5)) }
    maximum_points { rand(1..100) }
    due_date { Date.today + rand(-15..15).days }
    assignment_category
  end
end
