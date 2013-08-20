class AddColumnMultipleEntriesPerDayToStudentActionCategories < ActiveRecord::Migration
  def up
    add_column :student_action_categories, :allow_multiple_entries_per_date?, :boolean
  end

  def down
    remove_column :student_action_categories, :allow_multiple_entries_per_date?, :boolean
  end
end
