class User < ActiveRecord::Base
	has_many :contracts
	has_many :locations
  attr_accessible :email, :first_name, :last_name, :password, :zipcode

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
