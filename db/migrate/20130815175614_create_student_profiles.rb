class CreateStudentProfiles < ActiveRecord::Migration
  def change
  	create_table :student_profiles do |t|
  		t.string :gender, :null => false
  		t.date :birthday, :null => false
  		t.string :address
  		t.string :ccsd_id, :null => false
  		t.integer :grade_level, :null => false
  		t.string :email

  		t.timestamps
  	end
  end
end
