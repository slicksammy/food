class Place < ActiveRecord::Base

  has_many :notes
  has_one :place_status
  has_one :status, through: :place_status
  has_many :callbacks
  belongs_to :place_type

  def self.grocery
    where(place_type_id: PlaceType::GROCERY_ID)
  end

  def self.apartment
    where(place_type_id: PlaceType::APARTMENT_ID)
  end

  def self.vendor
    where(place_type_id: PlaceType::VENDOR_ID)
  end

  def status=(id)
    p = place_status || PlaceStatus.new(place_id: self.id)
    p.status_id = id
    p.save!
  end
end
