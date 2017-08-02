require_relative 'order_options'
require_relative 'order_totals'

module Checkout
  class OrderPrepare

    attr_reader :cart, :options
    attr_accessor :order

    def initialize(cart)
      @cart = cart
    end

    def prepare
      create_order
      set_totals
      set_options

      order
    end

    private

    def create_order
      @order = cart.order || cart.create_order
    end

    def set_totals
      totals = ::Checkout::OrderTotals.new(cart: cart).get_totals
      order.update_attributes(totals)
    end

    def set_options
      options = ::Checkout::OrderOptions.new(cart)

      # check to make sure order is not stale and has a date
      unless options.delivery_dates.include? order.expected_delivery_date
        order.expected_delivery_date = options.earliest_available_delivery_date
      end
      # set address unless user has set it
      unless order.address
        order.address = options.default_address
      end

      # set stripe_token unless user has set it
      unless order.stripe_token
        order.stripe_token = options.default_stripe_token
      end
      
      order.save!
    end
  end
end
