class AddIndexToAssignmentsAndSubmissions < ActiveRecord::Migration
  def change
  	add_index :assignments, :archived
  	add_index :submissions, :archived
  	add_index :assignments, :due_date
  	add_index :assignments, :course_id
  	add_index :assignments, :term
  	add_index :submissions, :term
  end
end
