class ChangeLocationAvailability < ActiveRecord::Migration
  def up
  	change_column :locations, :available, :date
  end
end
