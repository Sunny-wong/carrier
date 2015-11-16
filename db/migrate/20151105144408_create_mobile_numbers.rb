class CreateMobileNumbers < ActiveRecord::Migration
  def change
    create_table :mobile_numbers do |t|
      t.string :number, limit: 20
      t.belongs_to :mobile_number_section
      t.integer :mark

      t.timestamps null: false
    end
    
    add_index :mobile_numbers, :mobile_number_section_id
    add_index :mobile_numbers, :number, unique: true 
  end
end
