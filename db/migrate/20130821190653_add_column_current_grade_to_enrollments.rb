class AddColumnCurrentGradeToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :current_grade, :integer
  end
end