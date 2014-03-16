class AddIndexesForScholarHours < ActiveRecord::Migration
  def change
    add_index :scholar_hours, :date_assigned
    add_index :scholar_hours, [:student_id, :date_assigned]
    add_index :scholar_hours, [:status, :date_assigned, :student_id]
  end
end
