class AddColumnLoginCounter < ActiveRecord::Migration
  def change
    add_column :identities, :login_counter, :integer, :default => 0
  end
end
