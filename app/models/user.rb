class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :zipcode

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
