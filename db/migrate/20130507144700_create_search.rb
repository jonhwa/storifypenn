class CreateSearches < ActiveRecord::Migration
  def up
		create_table :search do |t|
      t.string :address
      t.date :begin_time
      t.date :end_time

      t.timestamps
    end
	end

  def down
    drop_table :search
  end
end
