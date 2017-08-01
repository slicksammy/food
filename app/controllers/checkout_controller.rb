require 'checkout/order_prepare'
require 'checkout/order_options'
require 'checkout/order_totals'
require 'stripe/make_charge'

class CheckoutController < SessionsController
  include CheckoutHelper

  before_action :allow_update_order_params, only: [:update_order, :safe_update]
  before_action :redirect_to_login_if_neccessary

  def view
    create_items

    # only show the main checkout page if there are items in the cart
    if @items
      create_order
      create_options

      render 'view', status: 202
    else 
      @message = 'nothing here'

      render :file => 'public/nothing_here.html.erb', :status => :not_found, :layout => 'bootstrap'
    end
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
    if ::Stripe::MakeCharge.new(order).charge!
      order.purchase!
      render body: nil, status: 202
    else
      render body: nil, status: 401
    end
  end

  private

  def cart_uuid
    session[:cart_uuid]
  end

  def order
    # dont want to cache order here bc it gets updated in some methods
    cart.try(:order)
  end

  def create_order
    @order = format_order(::Checkout::OrderPrepare.new(cart).prepare)
  end

  def create_items
    @items = to_string(::Checkout::OrderTotals.new(cart).items)
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
