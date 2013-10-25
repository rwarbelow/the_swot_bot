# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    enrollment
    status_id { rand(1..3) }
    date { Date.today + rand(-15..15) }
  end
end
