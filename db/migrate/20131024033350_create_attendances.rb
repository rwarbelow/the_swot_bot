class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :enrollment
      t.integer :status_id
      t.date :date

      t.timestamps
    end
    add_index :attendances, :enrollment_id
  end
end
