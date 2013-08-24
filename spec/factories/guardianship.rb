require 'faker'

FactoryGirl.define do
  factory :guardianship do
    guardian
    student
    relationship_to_student 'Parent'
  end
end
