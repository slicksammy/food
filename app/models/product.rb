require 'uuid_helper'

# the name attribute should include it's weight, ie 'Prime Steak, 6oz'

class Product < ActiveRecord::Base
  include UUIDHelper
  # has_and_belongs_to_many :carts
end
