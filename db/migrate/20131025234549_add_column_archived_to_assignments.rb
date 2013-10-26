class AddColumnArchivedToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :archived, :boolean, :default => false
    add_column :assignments, :term, :string
  end
end
