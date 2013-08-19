class CreateCourses < ActiveRecord::Migration
 def change
  	create_table :courses do |t|
  		t.references :teacher
  		t.integer :subject_id
  		t.integer :period

  		t.timestamps
  	end
  end
end
