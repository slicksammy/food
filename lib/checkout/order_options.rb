# when a customer is ready to check out we need to set some defaults
# and this needs to be rechecked on every page load i.e. customer starts order today
# and wants to pay 3 days from now - his original delivery date was set for 2 days ago
# also working with only 1 supplier for now so his criteria are hard-coded here
require 'business_time'

module Checkout
  class OrderOptions

    attr_reader :user

    def initialize(cart)
      @user = cart.user
    end

    def addresses
      user.addresses
    end

    def stripe_tokens
      user.stripe_tokens
    end

    # idealy check address of last orderx
    def default_address
      addresses.ordered.last
    end

    # idealy check address of last order
    def default_stripe_token
      stripe_tokens.ordered.last
    end

    # this always needs to be checked
    def earliest_available_delivery_date
      # may need to be configged for same day delivery
      Time.now.hour < cutoff_time ? Date.tomorrow : Date.tomorrow + 1  
    end

    # offering next 3 days delivery
    # instead of +n need to use business days
    def delivery_dates
      #(0..2).to_a.map { |n| earliest_available_delivery_date + n }
      (1..3).to_a.map { |n| n.business_days.from_now }.map(&:to_date)
    end

    def cutoff_time
      # time zone is configged to US central so we don't have to specify here
      # 5 pm cutoff time
      17
    end
  end
end
