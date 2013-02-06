class Contract < ActiveRecord::Base
  belongs_to :seller_user
  belongs_to :buyer_user
  belongs_to :location
  attr_accessible :begin, :end, :rate
end
