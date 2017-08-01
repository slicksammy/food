require 'uuid_helper'

class StripeCharge < ActiveRecord::Base

  belongs_to :stripe_token, primary_key: :uuid, foreign_key: :stripe_token_uuid
  belongs_to :order, primary_key: :uuid, foreign_key: :order_uuid

  scope :succeeded, -> { where(status: SUCCESS_STATUS) }

  SUCCESS_STATUS = 'succeeded'

  monetize :amount_cents

end
