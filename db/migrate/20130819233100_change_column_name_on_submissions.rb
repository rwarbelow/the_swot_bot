class ChangeColumnNameOnSubmissions < ActiveRecord::Migration
  def up
  	rename_column :submissions, :score, :points_earned
  end

  def down
  	rename_column :submissions, :points_earned, :score
  end
end

