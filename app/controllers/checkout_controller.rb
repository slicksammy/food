require 'checkout/order_prepare'
require 'checkout/order_options'
require 'checkout/order_totals'
require 'stripe/make_charge'
require 'checkout/final_order_check'

class CheckoutController < SessionsController
  include CheckoutHelper

  before_action :allow_update_order_params, only: [:update_order, :safe_update]
  before_action :allow_promo_params, only: [:apply_promo]
  before_action :redirect_to_login_if_neccessary

  def view
    begin
      create_items # error will be raised here first
      create_order
      create_options

      render 'view', status: 202
    rescue Checkout::OrderTotals::MissingCartError, Checkout::OrderTotals::NoItemsInCart => e
      @message = 'Nothing Here'
      @signed_in = logged_in?

      render :file => 'public/nothing_here.html.erb'
    end
  end

  def redirect_to_login_if_neccessary
    @redirect_url = '/checkout'
    super
  end

  # this route is for updating shipping address (address_id), payment method (stripe_token_id), or delivery date (expected_delivery_date)
  # def update_order
  #   order = Cart.find cart_id

  #   order.update_attributes!(params["order"])
  # end

  def update_order
    params[:order].each_pair do |k,v|
      if k == "expected_delivery_date"
        order.update_attributes!(expected_delivery_date: v)
      else
        obj = k.camelize.constantize.find_by_uuid v
        if obj.user == current_user 
          order.update_attributes!(:"#{k}" => obj)
        end
      end
    end
  end

  # TODO finish this
  def apply_promo
    params["code"]

    create_order

    render body: nil, json: { order: @order }
  end

  def buy
    # TODO add validation to order before buying
    # ie customer keeps tab open with next day delivery and then trys buying on same date again
    # or prices have changed
    # error message should be "please refresh and try again"

    valid = ::Checkout::FinalOrderCheck.new(params["order"], order).valid?

    if !valid
      render body: nil, status: 401, json: { error: 'oops, there was an error please refresh the page and try again' }
    else
      begin
        ::Stripe::MakeCharge.new(order).charge!
        order.purchase!
        # caching order here because first we clear cart (more important than sending email) but we still need access to the order for the email
        cached_order = order
        clear_cart
        OrderMailer.order_confirmation(cached_order).deliver!
        render body: nil, status: 202
      # the user will not know that he didn't pay the second time
      rescue ::Stripe::MakeCharge::DuplicateChargeError, ::Net::SMTPFatalError => e
        clear_cart
        render body: nil, status: 202 #, json: { error: 'Order has already been paid for' }
      end
    end
  end

  private

  def clear_cart
    session[:cart_uuid] = nil
  end

  def order
    cart.try(:order)
  end

  def create_order
    @order = format_order(::Checkout::OrderPrepare.new(cart).prepare)
  end

  def create_items
    @items = to_string(::Checkout::OrderTotals.new(cart: cart).items)
  end

  def create_options
    options = ::Checkout::OrderOptions.new(cart)

    # @address_options = format_addresses(options.addresses)
    # @payment_options = options.stripe_tokens
    @delivery_options = options.delivery_dates.map { |n| { value: n, display: format_date(n)} }
  end

  def allow_update_order_params
    params.require(:order)
  end

  def allow_promo_params
    params.require(:code)
  end
end
