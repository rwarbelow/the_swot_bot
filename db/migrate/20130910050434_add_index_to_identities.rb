class AddIndexToIdentities < ActiveRecord::Migration
  def change
  	add_index :identities, :first_name
  	add_index :identities, :last_name
  end
end
