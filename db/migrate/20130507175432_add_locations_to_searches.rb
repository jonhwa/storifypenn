class AddLocationsToSearches < ActiveRecord::Migration
  def change
  	add_column :searches, :locations, :string
  end
end
