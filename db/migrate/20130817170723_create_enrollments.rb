class CreateEnrollments < ActiveRecord::Migration
  def change
  	create_table :enrollments do |t|
  		t.references :student
  		t.references :course

  		t.timestamps
  	end
  end
end
