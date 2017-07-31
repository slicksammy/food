require 'checkout/order_prepare'
require 'checkout/order_options'
require 'checkout/order_totals'

class CheckoutController < SessionsController
  include CheckoutHelper

  before_action :allow_update_order_params, only: [:update_order, :safe_update]
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
    create_order_and_items
    create_options
  end

  # this route is for updating shipping address (address_id), payment method (stripe_token_id), or delivery date (expected_delivery_date)
  # def update_order
  #   order = Cart.find cart_id

  #   order.update_attributes!(params["order"])
  # end

  def update_order
    params[:order].each_pair do |k,v|
      obj = k.camelize.constantize.find_by_uuid v
      if obj.user == current_user 
        order.update_attributes!(:"#{k}" => obj)
      end
    end
  end

  def buy

  end

  def get_options
    klazz = option_type.camelize.constantize

    options = klazz.for_user(current_user)
    formatted_addr = format_addresses(addresses)

    render json: { options: formatted_addr }
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
    cart.order
  end

  def create_order_and_items
    @order = ::Checkout::OrderPrepare.new(cart).prepare
    @items = ::Checkout::OrderTotals.new(cart).items
  end

  def create_options
    options = ::Checkout::OrderOptions.new(cart)

    @address_options = format_addresses(options.addresses)
    @payment_options = options.stripe_tokens
    @delivery_options = options.delivery_dates.map { |n| { id: n, display: n} }
  end

  def create_addresses
    addresses = current_user.addresses
    @addresses = format_addresses(addresses)
  end

  def allow_update_order_params
    params.require(:order)
  end

  def cart
    Cart.find_by_uuid cart_uuid
  end

  # the id mapping is a hack bc the component uses id as the value. can update these to have an explicit value
  def create_delivery_dates
    delivery_dates = ::Checkout::OrderDefaults.new(order).available_delivery_dates
    @delivery_dates = delivery_dates.map { |n| { value: n, display: n} }
  end
end
