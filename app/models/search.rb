class Search < ActiveRecord::Base
	attr_accessible :address, :begin_time, :end_time
	serialize :locations

  	def get_locations(address, dates)
  		# Convert date range into separate dates
  		beginDate, endDate = dates.split(' - ')
	    self.begin_time = Date.strptime(beginDate, '%m/%d/%Y')
	    self.end_time = Date.strptime(endDate, '%m/%d/%Y')

	    # Execute search
	    self.locations = Location.search(address, self.begin_time, self.end_time)
	end
end