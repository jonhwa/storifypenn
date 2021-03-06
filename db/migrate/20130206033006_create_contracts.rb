class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :seller_user
      t.belongs_to :buyer_user
      t.belongs_to :location
      t.date :begin
      t.date :end
      t.integer :rate

      t.timestamps
    end
    add_index :contracts, :seller_user_id
    add_index :contracts, :buyer_user_id
    add_index :contracts, :location_id
  end
end
