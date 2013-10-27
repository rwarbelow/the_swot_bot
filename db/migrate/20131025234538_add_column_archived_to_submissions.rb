class AddColumnArchivedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :archived, :boolean, :default => false
    add_column :submissions, :term, :string
  end
end
