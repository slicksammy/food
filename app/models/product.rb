require 'uuid_helper'

# the name attribute should include it's weight, ie 'Prime Steak, 6oz'

class Product < ActiveRecord::Base
  include UUIDHelper

  scope :active, -> { where(active: [nil, true]) }

  monetize :price_cents, :r_price_cents
  # has_and_belongs_to_many :carts
end
