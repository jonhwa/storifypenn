class ChangeDecimalTypes < ActiveRecord::Migration
  def up
  	change_column :locations, :rate, :decimal, :precision => 6, :scale => 2
  	change_column :locations, :width, :decimal, :precision => 5, :scale => 1
  	change_column :locations, :length, :decimal, :precision => 5, :scale => 1
  end

  def down
  end
end
