class Location < ActiveRecord::Base
	belongs_to :user
	has_many :contracts, :order => 'contracts.begin_time'
	attr_accessible :address, :city, :rate, :state, :zipcode, :user_id, :ac, :dehumidifier, :available, :alarm, :basement, :width, :length

	validates :address, :city, :state, :zipcode, :user, :width, :length, :rate, :presence => true
	validates :zipcode, :length => { :is => 5 }
	validates :zipcode, :numericality => { :only_integer => true }
	validates :rate, :width, :length, :numericality => true
	validates :rate, :width, :length, :numericality => { :greater_than_or_equal_to => 0 }

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
