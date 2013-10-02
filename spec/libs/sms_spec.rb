require 'spec_helper'

describe SmsBroadcaster do
  it "can broadcast to ALL THE STUDENTS' guardians" do
    guardianships = FactoryGirl.create_list(:guardianship, 3)
    guardian = guardianships.first.guardian
    guardian.phone_numbers.create kind: 'cell', number: '5555555555'

    expect(TextMessage).to(receive(:sendMessage).with(to: ['+15555555555'], message: "This is a test"))

    students = guardianships.map(&:student)
    SmsBroadcaster.broadcast(students, "This is a test")
  end
end
