class CreateEnrollments < ActiveRecord::Migration
  def change
  	create_table :enrollments do |t|
  		t.references :student_profile
  		t.references :course

  		t.timestamps
  	end
  end
end
