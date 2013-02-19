class Location < ActiveRecord::Base
	belongs_to :user
	attr_accessible :address, :city, :rate, :state, :zipcode, :user_id, :ac, :dehumidifier, :available

	validates :address, :city, :state, :zipcode, :available, :user, :presence => true
	validates :zipcode, :length => { :in => 5..10 }

	def user_name
		(user.first_name + " " + user.last_name) if user
	end
end
