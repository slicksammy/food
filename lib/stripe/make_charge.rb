# make the purchase
# should_validate is to make sure you don't charge customer twice but can override in special cases
require 'stripe'

module Stripe
  class MakeCharge
    def initialize(order, should_validate: true)
      @order = order
      @amount = order.total.fractional
      @stripe_token = order.stripe_token
      @should_validate = should_validate 
    end

    def charge!
      return if @should_validate && duplicate_charge?

      charge = Stripe::Charge.create(
        :amount => @amount,
        :currency => "usd",
        :description => "I Heart Meat",
        :source => 'tok_mastercard_prepaid' # @stripe_token,
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
