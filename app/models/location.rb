class Location < ActiveRecord::Base
	belongs_to :user
	attr_accessible :address, :city, :rate, :state, :zipcode, :user_id, :ac, :dehumidifier, :available

	validates :address, :city, :state, :zipcode, :user, :presence => true
	validates_inclusion_of :available, :in => [true, false]
	validates :zipcode, :length => { :is => 5 }
	validates :zipcode, :numericality => { :only_integer => true }

	geocoded_by :full_address
	after_validation :geocode

	def user_name
		(user.first_name + " " + user.last_name) if user
	end

	def full_address
		"#{self.address} #{self.city} #{self.state} #{self.zipcode}"
	end

	scope :cheapest, order('rate asc')
	scope :top_ten, limit(10)
end
