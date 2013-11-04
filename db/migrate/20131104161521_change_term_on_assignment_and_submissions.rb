class ChangeTermOnAssignmentAndSubmissions < ActiveRecord::Migration
  def change
    add_column :assignments, :term_id, :integer
    add_column :submissions, :term_id, :integer
  end
end
