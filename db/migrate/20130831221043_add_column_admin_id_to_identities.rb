class AddColumnAdminIdToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :admin_id, :integer
  end
end
