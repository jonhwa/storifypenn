class Location < ActiveRecord::Base
	belongs_to :user
	attr_accessible :address, :city, :rate, :state, :zipcode, :user_id, :ac, :dehumidifier, :available

	validates :address, :city, :state, :zipcode, :available, :user, :presence => true
	validates :zipcode, :length => { :in => 5..10 }

	geocoded_by :full_address
	after_validation :geocode

	def user_name
		(user.first_name + " " + user.last_name) if user
	end

	def full_address
		"#{self.address} #{self.city} #{self.state} #{self.zipcode}"
		#@location.address + " " + @location.city + " " + @location.state + " " + @location.zipcode
	end
end
