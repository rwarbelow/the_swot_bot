class AddColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :bank_balance, :integer, :default => 0
  end
end
