class ChangeGradeColumnToFloatInEnrollments < ActiveRecord::Migration
  def change
    change_column :enrollments, :current_grade, :float, :default => 1.0
  end
end
