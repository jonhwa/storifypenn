class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
	has_many :contracts
	has_many :locations
	attr_accessible :email, :first_name, :last_name, :password, :zipcode

	validates :first_name, :last_name, :email, :password, :presence => true
	validates :email, :email => true

	def name
		"#{self.first_name} #{self.last_name}"
	end
end
