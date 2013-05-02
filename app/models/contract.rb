class Contract < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :location
  attr_accessible :seller_id, :buyer_id, :location_id, :begin_time, :end_time, :rate

  validates :seller, :buyer, :location, :begin_time, :end_time, :presence => true
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

  def date_range(dates)
    beginDate, endDate = dates.split(' - ')
    self.begin_time = Date.strptime(beginDate, '%m/%d/%Y')
    self.end_time = Date.strptime(endDate, '%m/%d/%Y')
  end

  def self.getSellerActiveContracts(user_id, currentTime)
    where("seller_id = ? AND end_time > ?", user_id, currentTime).order("begin_time ASC")
  end

  def self.getSellerPastContracts(user_id, currentTime)
    where("seller_id = ? AND end_time < ?", user_id, currentTime).order("begin_time DESC")
  end

  def self.getBuyerActiveContracts(user_id, currentTime)
    where("buyer_id = ? AND end_time > ?", user_id, currentTime).order("begin_time ASC")
  end

  def self.getBuyerPastContracts(user_id, currentTime)
    where("buyer_id = ? AND end_time > ?", user_id, currentTime).order("begin_time DESC")
  end

  def validateDates
    booked = {}
    self.location.contracts.order('begin_time').each do |contract|
      dates = {contract.id => {'begin_time' => contract.begin_time.strftime('%B %d, %Y'), 'end_time' => contract.end_time.strftime('%B %d, %Y')}}
      booked.merge!(dates)
    end

    for contract in booked
      contractBegin = Date.strptime(contract[1]['begin_time'], "%B %d, %Y")
      contractEnd = Date.strptime(contract[1]['end_time'], "%B %d, %Y")

      if self.begin_time >= contractBegin and self.begin_time <= contractEnd
        errors.add(:begin_time, 'The starting date isn\'t available')
      end

      if (self.end_time >= contractBegin and self.end_time <= contractEnd) or (self.begin_time < contractBegin and self.end_time > contractEnd)
        errors.add(:end_time, 'The ending date isn\'t available')
      end
    end
  end
end