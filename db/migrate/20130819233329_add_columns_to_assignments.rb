class AddColumnsToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :due_date, :date, :null => false
    add_column :assignments, :maximum_points, :integer, :null => false, :default => 100
  end

  def down
    remove_column :assignments, :due_date, :date
    remove_column :assignments, :maximum_points, :integer
  end
end
