class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :address, :city, :state, :zipcode, :latitude, :longitude
	has_many :contracts
	has_many :locations

	validates :first_name, :last_name, :email, :presence => true
	validates :email, :email => true

  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

	def name
		"#{self.first_name} #{self.last_name}"
	end

  def full_address
    "#{self.address} #{self.city} #{self.state} #{self.zipcode}"
  end
end
