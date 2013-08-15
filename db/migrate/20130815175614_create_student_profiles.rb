class CreateStudentProfiles < ActiveRecord::Migration
  def change
  	create_table :student_profiles do |t|
  		t.references :student_role
  		t.string :gender, :null => false
  		t.date :birthday, :null => false
  		t.string :address
  		t.integer :ccsd_id, :null => false
  		t.integer :grade_level, :null => false
  		t.string :email
  		t.integer :cell_phone_number

  		t.timestamps
  	end
  end
end
