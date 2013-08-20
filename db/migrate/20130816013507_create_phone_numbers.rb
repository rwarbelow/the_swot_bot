class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
    	t.string :number 
    	t.string :kind
    	t.integer :phone_numberable_id
    	t.string :phone_numberable_type

    	t.timestamps
    end
  end
end
