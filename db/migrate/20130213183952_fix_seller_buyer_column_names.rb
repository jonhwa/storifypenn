class FixSellerBuyerColumnNames < ActiveRecord::Migration
  def up
  	rename_column :contracts, :seller_user_id, :seller_id
  	rename_column :contracts, :buyer_user_id, :buyer_id
  end

  def down
  end
end
