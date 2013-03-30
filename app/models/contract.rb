class Contract < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :location
  attr_accessible :seller_id, :buyer_id, :location_id, :begin, :end, :rate

  validates :seller, :buyer, :location, :presence => true
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

  def validateDates
    booked = {}
    Contract.where("location_id = #{@location.id}").order("begin").each do |contract|
      dates = {contract.id => {'begin' => contract.begin.strftime('%B %d, %Y'), 'end' => contract.end.strftime('%B %d, %Y')}}
      booked.merge!(dates)
    end

    for contract in booked
      contractBegin = booked[contract].begin
      contractEnd = booked[contract].end

      if record.begin >= contractBegin and record.begin <= contractEnd
        record.errors[:begin] << 'The starting date isn\'t available'
      end

      if record.end >= contractBegin and record.end <= contractEnd
        record.errors[:end] << 'The ending date isn\'t available'
      end
    end
  end
end