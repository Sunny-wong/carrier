class CreateMobileNumberSections < ActiveRecord::Migration
  def change
    create_table :mobile_number_sections do |t|
      t.string :mts, limit: 10
      t.string :carrier
      t.belongs_to :area_code
      t.integer :mobile_numbers_count

      t.timestamps null: false
    end
    
    add_index :mobile_number_sections, :area_code_id
    add_index :mobile_number_sections, :mts, unique: true 
  end
end
