class AddColumnsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :ac, :boolean
    add_column :locations, :dehumidifier, :boolean
    add_column :locations, :available, :boolean
  end
end
