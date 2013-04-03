class AddAmenitiesToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :basement, :boolean
  	add_column :locations, :alarm, :boolean
  end
end
