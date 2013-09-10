class AddIndexToStudentActionType < ActiveRecord::Migration
  def change
  	add_index :student_action_types, :value
  	add_index :student_action_types, :name
  end
end
