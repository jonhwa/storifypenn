class Location < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :city, :rate, :state, :zipcode, :user_id

  def user_name
  	(user.first_name + " " + user.last_name) if user
  end
end
