class AddColumnToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :subject, :string
  end

  def down
    remove_column :messages, :subject, :string
  end
end
