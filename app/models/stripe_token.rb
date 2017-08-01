require 'uuid_helper'

class StripeToken < ActiveRecord::Base
  include UUIDHelper

  scope :ordered, -> { order(created_at: :desc) }

  has_many :orders, primary_key: :uuid, foreign_key: :stripe_token_uuid

  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid

  def make_active_and_others_inactive!
    all = StripeToken.where(user_id: self.user_id)
    all.each { |a| a.deactivate! }
    self.activate!
  end

  def deactivate!
    self.active = false
    self.save!
  end

  def activate!
    self.active = true
    self.save!
  end

  def formatted_last_4
    "card ending in #{self.last_4}"
  end
end
