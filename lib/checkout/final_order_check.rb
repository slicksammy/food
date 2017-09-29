require_relative 'order_prepare'
require 'delivery/availability'

module Checkout
  class FinalOrderCheck

    attr_reader :order_details, :order

    def initialize(order_details, order)
      @order_details = order_details
      @order = order
    end

    def valid?      
      totals = ::Checkout::OrderTotals.new(order: order).get_totals

      available_delivery_dates = ::Checkout::OrderOptions.new(order.cart).delivery_dates

      valid_exptected_delivery_date?(available_delivery_dates) && valid_total?(totals)
    end

    private

    def valid_exptected_delivery_date?(dates)
      dates.include? order.expected_delivery_date
    end

    def valid_total?(totals)
      totals[:total] == order_details[:total].to_money
    end

    def valid_stripe_token?
      # probably need to check if stripe token is not only present but valid
      order.stripe_token_id
    end

    def valid_address?
      # order.address_id && # address in proximity
    end

  end

  # should use state machine
  # def confirm!
  #   if total && stripe_token_id && expected_delivery_date && address_id
  #     self.status = 'confirmed'
  #     self.save!
  #   else
  #      raise CannotConfirmError 
  #   end
  # end

  class CannotConfirmError < StandardError

    def message
      "missing info"
    end
  end
end
