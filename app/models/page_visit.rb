require 'uuid_helper'

class PageVisit < ActiveRecord::Base
  include UUIDHelper
  
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  scope :ordered, -> { order("created_at ASC") }

  def admin?
    !!user.try(:admin?)
  end
end
