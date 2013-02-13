class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :location
  attr_accessible :seller_id, :buyer_id, :location_id, :begin, :end, :rate

  def seller_name
  	(seller.first_name + " " + seller.last_name) if seller
  end

  def buyer_name
  	(buyer.first_name + " " + buyer.last_name) if buyer
  end

  def location_addr
  	location.address if location
  end
end
