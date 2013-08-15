class CreateRoles < ActiveRecord::Migration
  def change
  	create_table :roles do |t|
  		t.references :user_identity
  		t.string :type, :null => false

  		t.timestamps
  	end
  end
end
