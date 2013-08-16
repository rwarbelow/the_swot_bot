class ReplaceRolesWithReferences < ActiveRecord::Migration
  def up
  	drop_table :roles
  	add_column :user_identities, :student_profile_id, :integer
  	add_column :user_identities, :teacher_profile_id, :integer
  	add_column :user_identities, :guardian_profile_id, :integer
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
