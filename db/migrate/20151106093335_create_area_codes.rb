class CreateAreaCodes < ActiveRecord::Migration
  def change
    create_table :area_codes do |t|
      t.string :province
      t.string :city
      t.integer :code

      t.timestamps null: false
    end
  end
end
