class CreateNotFoundMobileNumbers < ActiveRecord::Migration
  def change
    create_table :not_found_mobile_numbers do |t|
      t.string :number, limit: 20
      t.integer :mark

      t.timestamps null: false
    end
    
    add_index :not_found_mobile_numbers, :number
  end
end
