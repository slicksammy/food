require 'uuid_helper'

# the name attribute should include it's weight, ie 'Prime Steak, 6oz'

class Product < ActiveRecord::Base
  include UUIDHelper

  STEAK_TYPE = 'steak'

  scope :active, -> { where(active: [nil, true]) }
  scope :promotional, -> { where(promotional: true) }
  scope :ordered, -> { order("created_at DESC") }
  scope :steak, -> { where(product_type: STEAK_TYPE) }
  scope :not_steak, -> { where("product_type is NULL or product_type != ?", self::STEAK_TYPE) }

  monetize :price_cents, :r_price_cents, :regular_price_cents
  # has_and_belongs_to_many :carts

  def self.promotional_product
    ordered.promotional.first
  end
end
