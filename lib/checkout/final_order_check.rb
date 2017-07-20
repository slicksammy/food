require 'checkout/order_defaults'
require 'delivery/availability'

module Checkout
  class FinalOrderCheck

    attr_reader :order

    def initialize(order)
      @order = order
    end

    def is_valid?
      valid_exptected_delivery_date? && has_stripe_token? && correct_totals? && valid_address?
    end

    private

    def valid_exptected_delivery_date?
      order.expected_delivery_date && order.expected_delivery_date >= ::Checkout::OrderDefaults.cutoff_time
    end

    def valid_totals?
      # I should check this but maybe don't need to
    end

    def valid_stripe_token?
      # probably need to check if stripe token is not only present but valid
      order.stripe_token_id
    end

    def valid_address?
      order.address_id && # address in proximity
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
