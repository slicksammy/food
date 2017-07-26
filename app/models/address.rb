require 'uuid_helper'

class Address < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include UUIDHelper

  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  def formatted
    formatted_address = "#{self.street_number} #{self.street_name}"
    formatted_address += ", #{self.address_2}" if self.address_2
    formatted_address += ", #{self.city}, #{self.state}, #{self.zip}"
    formatted_address
  end
end
