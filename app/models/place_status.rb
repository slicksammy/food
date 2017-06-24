class PlaceStatus < ActiveRecord::Base
  belongs_to :place
  belongs_to :status
end
