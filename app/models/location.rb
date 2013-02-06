class Location < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :city, :rate, :state, :zipcode
end
