class AddColumnForStudentRegCode < ActiveRecord::Migration
  def up
    add_column :students, :registration_code, :string
  end

  def down
    remove_column :students, :registration_code, :string
  end
end
