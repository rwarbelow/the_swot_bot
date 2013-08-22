class ChangeColumnInEnrollments < ActiveRecord::Migration
  def change
    change_column :enrollments, :current_grade, :integer, :default => 100
  end
end
