class ChangeColumnNamesBeginEnd < ActiveRecord::Migration
  def up
  	rename_column :contracts, :begin, :begin_time
  	rename_column :contracts, :end, :end_time
  end

  def down
  	rename_column :contracts, :begin_time, :begin
  	rename_column :contracts, :end_time, :end
  end
end
