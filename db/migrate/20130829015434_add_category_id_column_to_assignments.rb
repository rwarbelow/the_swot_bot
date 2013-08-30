class AddCategoryIdColumnToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :assignment_category_id, :integer
  end

  def down
    remove_column :assignments, :assignment_category_id, :integer
  end
end
