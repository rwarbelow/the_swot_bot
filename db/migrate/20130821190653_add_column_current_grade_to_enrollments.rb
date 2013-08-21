class AddColumnCurrentGradeToEnrollments < ActiveRecord::Migration
  def up
    add_column :enrollments, :current_grade, :integer
  end

  def down
    remove_column :enrollments, :current_grade, :integer
  end
end
