class CreateStudentProfiles < ActiveRecord::Migration
  def change
  	create_table :student_profiles do |t|
  		t.references :student_role
  		t.string :gender, :null => false
  		t.string :birthday, :null => false
  		t.string :address
  		t.integer :ccsd_id, :null => false
  		t.string :grade_level, :null => false
  		t.string :email
  		t.string :cell_phone_number

  		t.timestamps
  	end
  end
end
