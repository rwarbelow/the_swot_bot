class AddIndexScholarHourStatus < ActiveRecord::Migration
  def change
  	add_index :scholar_hours, :status
  	add_index :scholar_hours, [:student_id, :status]
  	add_index :scholar_hours, [:date_assigned, :status]
  	add_index :scholar_hours, [:date_assigned, :status, :student_id]
  end
end
