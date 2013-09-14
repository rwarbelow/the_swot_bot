class AddColumnCommentsToScholarHours < ActiveRecord::Migration
  def change
    add_column :scholar_hours, :comments, :string
  end
end
