class AddIndexToStudentActions < ActiveRecord::Migration
  def change
  	add_index :student_actions, :date
  end
end
