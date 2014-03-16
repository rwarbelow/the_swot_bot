class AddIndexToScholarHours < ActiveRecord::Migration
  def change
    add_index :scholar_hours, :status
    add_index :scholar_hours, [:status, :student_id]
  end
end
