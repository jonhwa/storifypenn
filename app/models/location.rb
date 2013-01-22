class Location < ActiveRecord::Base
  attr_accessible :address, :city, :name, :rate, :state, :zipcode
end
