require 'spec_helper'

describe Teachers::LiveController do
  describe 'POST /live_class' do
    def session
      { user_id: @current_user.identity.id }
    end

    before(:all) do
      @course = FactoryGirl.create :course
      @current_user = @course.teacher

      category = StudentActionCategory.create name: 'attendance'
      category.student_action_types.create name: 'on-time', value: 1
      category.student_action_types.create name: 'tardy', value: 0
      category.student_action_types.create name: 'absent', value: -1

      students = @course.students = FactoryGirl.create_list :student, 6
      @attendance_data = {
        'on_time' => students[0..1].map(&:id),
        'absent'  => students[2..3].map(&:id),
        'tardy'   => students[4..5].map(&:id),
      }
    end

    after(:each) do
      Attendance.destroy_all
    end

    it 'creates attendance records if attendance data is sent' do
      expect {
        post :create_action, {course_id: @course.id}.merge(@attendance_data), session
      }.to change{Attendance.count}.by(6)
    end

    it "doesn't create any new records if attendance data has already been sent" do
      post :create_action, {course_id: @course.id}.merge(@attendance_data), session
      expect {
        post :create_action, {course_id: @course.id}.merge(@attendance_data), session
      }.to change{Attendance.count}.by(0)
    end

    it 'updates attendance data if attendance data has already been sent' do
      post :create_action, {course_id: @course.id}.merge(@attendance_data), session

      attendance_data = @attendance_data.dup
      attendance_data['on_time'] += attendance_data.delete('tardy')
      attendance_data['on_time'] += attendance_data.delete('absent')

      post :create_action, {course_id: @course.id}.merge(attendance_data), session
      Attendance.where(status_id: Attendance::STATUSES['present']).count.should eq(6)
      Attendance.where(status_id: Attendance::STATUSES['present']).map {|attendance| attendance.enrollment }.compact.count.should eq(6)
      Attendance.count.should eq(6)
    end
  end
end
