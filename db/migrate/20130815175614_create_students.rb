class CreateStudents < ActiveRecord::Migration
  def change
  	create_table :students do |t|
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
