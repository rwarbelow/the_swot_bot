class CreateGuardians < ActiveRecord::Migration
  def change
  	create_table :guardians do |t|
  		t.string :address
  		t.string :email
  		t.string :preferred_language, :null => false, :default => 'English'

  		t.timestamps
  	end
  end
end
