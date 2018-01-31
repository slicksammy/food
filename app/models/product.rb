require 'uuid_helper'

# the name attribute should include it's weight, ie 'Prime Steak, 6oz'

class Product < ActiveRecord::Base
  include UUIDHelper

  scope :active, -> { where(active: [nil, true]) }
  scope :promotional, -> { where(promotional: true) }
  scope :ordered, -> { order("created_at DESC") }

  monetize :price_cents, :r_price_cents, :regular_price_cents
  # has_and_belongs_to_many :carts

  def self.promotional_product
    ordered.promotional.first
  end
end
