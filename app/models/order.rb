require 'uuid_helper'

class Order < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include UUIDHelper

  belongs_to :cart, foreign_key: :cart_uuid, primary_key: :uuid
  belongs_to :address, foreign_key: :address_uuid, primary_key: :uuid
  belongs_to :stripe_token, primary_key: :uuid, foreign_key: :stripe_token_uuid
  has_many :stripe_charges, primary_key: :uuid, foreign_key: :order_uuid

  monetize :subtotal_cents, :tax_cents, :shipping_cents, :total_cents

  PURCHASED_STATUS = 'paid'

  def confirm!
    self.status = 'confirmed'
    self.save!
  end

  def paid?
    stripe_charges.succeeded.any?
  end

  def valid_expected_delivery_date?
    expected_delivery_date
  end

  # hack but will do for now
  # there can be overlap here but by name and order_number we should be able to locate the order
  def order_number
    uuid.first(6)
  end

  def purchase!
    self.status = PURCHASED_STATUS
    self.save!
  end

  def fulfill!
    # company has boxed the product
  end

  def deliver!
    # package has been delivered
  end

  def ask_for_refund!
    # customer has asked for refund
  end

  def refund!
    # product has been refunded
  end
end
