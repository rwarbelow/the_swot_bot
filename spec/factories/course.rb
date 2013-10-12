require 'faker'

FactoryGirl.define do
  factory :course do
    teacher
    subject
    period { rand(1..10) }
  end
end
