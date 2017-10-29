require 'uuid_helper'
require 'checkout/order_totals'

class Order < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include UUIDHelper

  belongs_to :cart, foreign_key: :cart_uuid, primary_key: :uuid
  belongs_to :address, foreign_key: :address_uuid, primary_key: :uuid
  belongs_to :stripe_token, primary_key: :uuid, foreign_key: :stripe_token_uuid
  has_many :stripe_charges, primary_key: :uuid, foreign_key: :order_uuid
  has_many :order_status_logs, primary_key: :uuid, foreign_key: :order_uuid
  has_one :user, through: :cart
  belongs_to :promotion

  monetize :subtotal_cents, :tax_cents, :shipping_cents, :total_cents, :discount_cents

  scope :ongoing, -> { where(status: ONGOING_STATUS) }

  scope :completed, -> { where.not(status: nil) }

  scope :ordered, -> { order("created_at DESC") }

  scope :paid, -> { where(status: PURCHASED_STATUS ) }

  scope :for_today, -> { where(expected_delivery_date: Date.today) }

  scope :in_the_last_hours, ->(hours) { where("created_at > ?", hours.hours.ago ) }

  after_save :create_order_status_log, if: :saved_change_to_status?

  serialize :products, Array

  PURCHASED_STATUS = 'paid'
  DElIVERED_STATUS = 'delivered'
  ONGOING_STATUS = nil

  def self.find_by_order_number(order_number)
    all.select { |o| o.order_number.downcase == order_number.downcase }
  end

  def confirm!
    self.status = 'confirmed'
    self.save!
  end

  def delivered_on
    # find the last log
    order_status_logs.ordered.find { |log| log.status == DElIVERED_STATUS }.try(:created_at)
  end

  def paid?
    stripe_charges.succeeded.any?
  end

  def discounted?
    discount > 0
  end

  def valid_expected_delivery_date?
    expected_delivery_date
  end

  def create_order_status_log
    OrderStatusLog.create!(order: self, status: self.status)
  end

  # hack but will do for now
  # there can be overlap here but by name and order_number we should be able to locate the order
  def order_number
    uuid.first(6).upcase
  end

  def ongoing?
    self.status == ONGOING_STATUS
  end

  def delivered?
    self.status == DElIVERED_STATUS
  end

  def purchase!
    self.status = PURCHASED_STATUS
    set_products
    self.save!
  end

  def fulfill!
    # company has boxed the product
  end

  def deliver!
    self.status = DElIVERED_STATUS
    self.save!
  end

  def ask_for_refund!
    # customer has asked for refund
  end

  def refund!
    # product has been refunded
  end

  def set_products
    self.products = ::Checkout::OrderTotals.new(order: self).items
  end
end
