class ChangeRateFieldType < ActiveRecord::Migration
  def up
  	change_column :locations, :rate, :decimal
  end

  def down
  	change_column :locations, :rate, :integer
  end
end
