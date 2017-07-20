# make the purchase
# should_validate is to make sure you don't charge customer twice but can override in special cases
module Stripe
  class Charge
    def initialize(stripe_token, order, amount, should_validate: true)
    end

    def duplicate_charge?
      # need to make sure the customer doesn't submit twice
      # if should_validate
      # order.stripe_charge.present?
    end
  end
end
