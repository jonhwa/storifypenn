class RemoveSearchAddSearches < ActiveRecord::Migration
  def up
  	drop_table :search

  	create_table :searches do |t|
      t.string :address
      t.date :begin_time
      t.date :end_time

      t.timestamps
    end
  end

  def down
  end
end
