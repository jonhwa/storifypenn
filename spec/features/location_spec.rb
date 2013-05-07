require 'spec_helper'

describe 'Adding a location' do
	it 'requires an address' do
		visit root_path
		click_link 'Or list your own storage space'
		fill_in "City", with: "Philadelphia"
		fill_in "State", with: "PA"
		fill_in "Zipcode", with: "19104"
		fill_in "Width", with: "3"
		fill_in "Length", with: "2"
		fill_in "Rate", with: "3.19"
		click_button "Create Location"

		error_message = "Address can't be blank"
		page.should have_content?(error_message)
	end
end