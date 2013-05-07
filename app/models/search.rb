class Search < ActiveRecord::Base
	attr_accessible :address, :begin_time, :end_time

	def date_range(dates)
	    beginDate, endDate = dates.split(' - ')
	    self.begin_time = Date.strptime(beginDate, '%m/%d/%Y')
	    self.end_time = Date.strptime(endDate, '%m/%d/%Y')
  	end
end