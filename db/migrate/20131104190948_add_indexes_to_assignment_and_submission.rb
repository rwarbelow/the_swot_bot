class AddIndexesToAssignmentAndSubmission < ActiveRecord::Migration
  def change
	    add_index :assignments, :term_id
	    add_index :submissions, :term_id
	    add_index :submissions, [:term_id, :student_id]
  end
end
