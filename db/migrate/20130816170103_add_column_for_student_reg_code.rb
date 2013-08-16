class AddColumnForStudentRegCode < ActiveRecord::Migration
  def up
    add_column :student_profiles, :registration_code, :string
  end

  def down
    remove_column :student_profiles, :registration_code, :string
  end
end
