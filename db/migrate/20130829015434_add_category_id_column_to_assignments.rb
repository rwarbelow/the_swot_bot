class AddCategoryIdColumnToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :category_id, :integer
  end

  def down
    remove_column :assignments, :category_id, :integer
  end
end
