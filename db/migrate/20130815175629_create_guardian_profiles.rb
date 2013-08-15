class CreateGuardianProfiles < ActiveRecord::Migration
  def change
  	create_table :guardian_profiles do |t|
  		t.references :guardian_role
  		t.string :address
  		t.string :email
  		t.integer :cell_phone_number
  		t.integer :home_phone_number
  		t.integer :work_phone_number
  		t.string :preferred_language, :null => false, :default => 'English'

  		t.timestamps
  	end
  end
end
