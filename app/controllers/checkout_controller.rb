require 'checkout/order'
require 'checkout/order_defaults'

class CheckoutController < SessionsController
  include CheckoutHelper

  before_action :allow_update_order_params, only: [:update_order]
  before_action :redirect_to_login_if_neccessary

  # need to redirect in case there is nothing to view ie active order - probably should just be the store
  def view
    # move this into session controller
    # logged_in = session[:user_id].present?

    # unless logged_in
    #   redirect_to '/login'
    # end

    # has_credit_card? = User.find(session_user_id).active_card.present?

    # unless has_credit_card?
    #   redirect_to '/payment'
    # end

    # look into money gem https://github.com/RubyMoney/money-rails
    create_order
    create_stripe_tokens
    create_addresses
    create_delivery_dates
  end

  # this route is for updating shipping address (address_id), payment method (stripe_token_id), or delivery date (expected_delivery_date)
  def update_order
    order = Cart.find cart_id

    order.update_attributes!(params["order"])
  end

  def buy

  end

  # this should return whether it was succesful 
  def confirm_order
    # need to double check a few things before confirming
    # address is within delivery radius
    # delivery dates are OK
    if order.confirm!
      render status: 202, json: { confirmed: true, order_number: order.order_number }
    else
      # need to make this error code better, stubbed for now
      render status: 404, json: { confirmed: false, error: 'Something Unexpected Happened, please try again' }
    end
  end

  private

  def cart_uuid
    session[:cart_uuid]
  end

  def order
    # dont want to cache order here bc it gets updated in some methods
    ::Order.find_or_initialize_by(cart_uuid: cart_uuid)
  end

  def create_order
    m_order = Checkout::Order.new(cart_uuid)
    order = ::Order.find_or_initialize_by(cart_uuid: cart_uuid)
    # will not hit DB if there are not changes
    # need to add an address_id and a stripe_token_id to the order object so there are defaults when customer sees page
    order.update_attributes({subtotal: m_order.subtotal, tax: m_order.tax, total: m_order.total, shipping: m_order.shipping})
    @order = order
    @items = m_order.items
  end

  def create_stripe_tokens
    # will need to find by user.id
    # also need to send this as data not object bc too much info here
    payments = StripeToken.all.sort{ |a| a.active ? 0:1 }
    @payments = format_payments(payments)
  end

  def create_addresses
    addresses = Address.all
    @addresses = format_addresses(addresses)
  end

  def allow_update_order_params
    params.require(:order).permit!
  end

  # def create_delivery_dates
  #   (0..2).to_a.map do |n|

  #     date = Object.new

  #     def id=(x)
  #       self.id = x
  #     end

  #     def date=(y)
  #       self.date = y
  #     end

  #     date.id = n
  #     date.date = Date.today + n

  #     date
  #   end
  # end

  # the id mapping is a hack bc the component uses id as the value. can update these to have an explicit value
  def create_delivery_dates
    delivery_dates = ::Checkout::OrderDefaults.new(order).available_delivery_dates
    @delivery_dates = delivery_dates.map { |n| { id: n, display: n} }
  end
end
