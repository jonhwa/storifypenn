class Contract < ActiveRecord::Base
  belongs_to :seller
  belongs_to :buyer
  belongs_to :location
  attr_accessible :begin, :end, :rate
end
