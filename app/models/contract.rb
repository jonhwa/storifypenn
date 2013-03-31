class Contract < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :location
  attr_accessible :seller_id, :buyer_id, :location_id, :begin, :end, :rate

  validates :seller, :buyer, :location, :begin, :end, :presence => true
  validate :validateDates

  def seller_name
  	(seller.first_name + " " + seller.last_name) if seller
  end

  def buyer_name
  	(buyer.first_name + " " + buyer.last_name) if buyer
  end

  def location_addr
  	location.address if location
  end

  def get_location_id
    location.id
  end

  def validateDates
    booked = {}
    Contract.where("location_id = #{self.location.id}").order("begin").each do |contract|
      dates = {contract.id => {'begin' => contract.begin.strftime('%B %d, %Y'), 'end' => contract.end.strftime('%B %d, %Y')}}
      booked.merge!(dates)
    end
    #raise 'booked: ' + booked.to_s

    for contract in booked
      contractBegin = Date.strptime(contract[1]['begin'], "%B %d, %Y")
      contractEnd = Date.strptime(contract[1]['end'], "%B %d, %Y")

      if self.begin >= contractBegin and self.begin <= contractEnd
        errors.add(:begin, 'The starting date isn\'t available')
      end

      if self.end >= contractBegin and self.end <= contractEnd
        errors.add(:end, 'The ending date isn\'t available')
      end
    end
  end
end