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

	#Returns the city, state, and zipcode formatted
	def lower_address
		"#{self.city}, #{self.state} #{self.zipcode}"
	end

	def getActiveContracts
		self.contracts.where("end_time > ?", Date.today)
	end

	def getBookedDates
		booked = {}
		self.contracts.each do |contract|
			dates = {contract.id => {'begin_time' => contract.begin_time.strftime('%B %d, %Y'), 'end_time' => contract.end_time.strftime('%B %d, %Y')}}
			booked.merge!(dates)
		end
		booked = booked.to_json
	end

	#Returns a boolean of availability during the given dates
	def isAvailable(startDate, endDate)
		unless startDate.blank? or endDate.blank?
			contracts = getActiveContracts()
			contracts.each do |contract|
				beginTime = contract.begin_time
				endTime = contract.end_time
				if (beginTime..endTime).cover?(startDate) or (beginTime..endTime).cover?(endDate)
					return false
				end
			end
		end
		return true
	end

	#Finds locations belonging to a user
	def self.getUsersLocations(user_id)
		where("user_id = ?", user_id).order("created_at DESC")
	end

	#Executes a search given an address and requested dates
	def self.search(address, startDate, endDate)
		latlng = Geocoder.coordinates(address)
		rawLocations = self.near(latlng, 10)
		locations = []
		rawLocations.each do |location|
			if location.isAvailable(startDate, endDate)
				locations << location.id
			end
		end
		return locations
	end

	scope :cheapest, order('rate asc')
	scope :top_ten, limit(10)
end
