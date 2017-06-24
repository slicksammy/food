class Place < ActiveRecord::Base

  has_many :notes
  has_one :place_status
  has_one :status, through: :place_status
  has_many :callbacks

  def self.grocery
    where("internal_type similar to ?", '%grocery%')
  end

  def self.apartment
    where("internal_type similar to ?", '%(apartment|resid)%')
  end

  def status=(id)
    p = place_status || PlaceStatus.new(place_id: self.id)
    p.status_id = id
    p.save!
  end
end
