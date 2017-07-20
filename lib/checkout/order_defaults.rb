# when a customer is ready to check out we need to set some defaults
# and this needs to be rechecked on every page load i.e. customer starts order today
# and wants to pay 3 days from now - his original delivery date was set for 2 days ago
# also working with only 1 supplier for now so his criteria are hard-coded here
module Checkout
  class OrderDefaults

    attr_reader :expected_delivery_date
    attr_accessor :order

    def initialize(order)
      @order = order
      @expected_delivery_date = order.expected_delivery_date
    end

    # this always needs to be checked
    def self.earliest_available_delivery_date
      # may need to be configged for same day delivery
      delivery_date = Time.now.hour < cutoff_time ? Date.tomorrow : Date.tomorrow + 1  
    end

    def set_delivery_date
      # if we should update and there is no expected_delivery_date or expected_delivery_date is in the past
      if !expected_delivery_date || delivery_date > expected_delivery_date
        order.update_attributes({expected_delivery_date: delivery_date})
      end
    end

    def available_delivery_dates
      (0..2).to_a.map { |n| earliest_available_delivery_date + n }
    end

    # idealy check address of last order
    # but for now check if address is not set
    # this will save a customer a click
    def default_address
      # only check if address is not set
    end

    # idealy check address of last order
    # but for now check if address is not set
    # this will save a customer a click 
    def default_stripe_token
      # only check if stripe token is not set
    end

    def self.cutoff_time
      # time zone is configged to US central so we don't have to specify here
      # 5 pm cutoff time
      17
    end
  end
end
