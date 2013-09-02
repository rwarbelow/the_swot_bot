class AddColumnToScholarHours < ActiveRecord::Migration
  def change
    add_column :scholar_hours, :status, :string
  end
end
