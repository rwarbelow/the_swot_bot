class CreateGuardianships < ActiveRecord::Migration
  def change
  	create_table :guardianships do |t|
  		t.references :student
  		t.references :guardian
  		t.string :relationship_to_student, :null => false

  		t.timestamps
  	end
  end
end
