class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :seller
      t.belongs_to :buyer
      t.belongs_to :location
      t.date :begin
      t.date :end
      t.integer :rate

      t.timestamps
    end
    add_index :contracts, :seller_id
    add_index :contracts, :buyer_id
    add_index :contracts, :location_id
  end
end
