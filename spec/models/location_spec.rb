require 'spec_helper'

describe Location do
	user = User.create
	user.first_name = 'Jonathan'
	user.last_name = 'Hwa'
	user.email = 'test@gmail.com'
	user.password = 'password'

	it "requires an address" do
		subject.city = 'Philadelphia'
		subject.state = 'PA'
		subject.zipcode = 19104
		subject.available = true
		subject.user = user
		subject.should_not be_valid
		subject.address = '3901 Locust Walk'
		subject.should be_valid
	end

	it "requires a proper length zipcode" do
		subject.city = 'Philadelphia'
		subject.state = 'PA'
		subject.address = '3901 Locust Walk'
		subject.available = true
		subject.user = user
		subject.zipcode = 1910
		subject.should_not be_valid
		subject.zipcode = 12345678901
		subject.should_not be_valid
		subject.zipcode = 19104
		subject.should be_valid
		subject.zipcode = 191040987
		subject.should be_valid
	end
end