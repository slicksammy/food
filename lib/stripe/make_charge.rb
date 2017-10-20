# make the purchase
# should_validate is to make sure you don't charge customer twice but can override in special cases
require 'stripe'

module Stripe
  class MakeCharge

    class DuplicateChargeError < StandardError
    end

    def initialize(order, should_validate: true)
      @order = order
      @amount = order.total.fractional
      @stripe_customer_id = order.user.stripe_customer.stripe_customer_id
      @stripe_token = order.stripe_token
      @should_validate = should_validate 
    end

    def charge!
      raise MakeCharge::DuplicateChargeError if @should_validate && duplicate_charge?

      charge = Stripe::Charge.create(
        :amount => @amount,
        :currency => "usd",
        :description => "iheartmeat",
        :customer => @stripe_customer_id,
        :source => @stripe_token.stripe_card.stripe_card_id,
      )

      save_info(charge)
    end

    def save_info(charge)
      ::StripeCharge.create!(
        amount_cents: charge.amount,
        status: charge.status,
        order: @order,
        stripe_token: @stripe_token,
        response: charge
      )
    end

    def duplicate_charge?
      @order.paid?
    end
  end
end
