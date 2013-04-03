class AddLengthWidthToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :length, :decimal
  	add_column :locations, :width, :decimal
  end
end
