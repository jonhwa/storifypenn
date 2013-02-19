require 'spec_helper'

describe 'Adding a user' do
	include Capybara::DSL
	it 'requires an email' do
		visit users_path
		click_link "New User"
		fill_in "First name", with: "Jonathan"
		fill_in "Last name", with: "Hwa"
		fill_in "Password", with: "password"
		click_button "Create User"

		error_message = "Email can't be blank"
		page.should have_content(error_message)
	end

	it 'requires a properly formatted email' do
		visit users_path
		click_link "New User"
		fill_in "First name", with: "Jonathan"
		fill_in "Last name", with: "Hwa"
		fill_in "Email", with: "test@gmail"
		fill_in "Password", with: "password"
		click_button "Create User"

		error_message = "Email is not an email"
		page.should have_content(error_message)
	end
end
