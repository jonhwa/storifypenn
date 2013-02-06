class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :rate
      t.belongs_to :user

      t.timestamps
    end
    add_index :locations, :user_id
  end
end
