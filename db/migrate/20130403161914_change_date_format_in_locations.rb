class ChangeDateFormatInLocations < ActiveRecord::Migration
  def up
  	change_column :locations, :available, :text
  end

  def down
  	change_column :locations, :available, :date
  end
end
