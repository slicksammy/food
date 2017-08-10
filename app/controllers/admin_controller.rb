require 'checkout/order_totals'

class AdminController < SessionsController
  include CheckoutHelper

  # TODO uncomment - commented for now for testing purposes
  # before_action :authorize!

  def authorize!
    redirect_to '/' unless admin?
  end

  def index
    orders = Order.all
    @orders = format_orders(orders)
  end

  private

  def admin?
    current_user && current_user.admin?
  end

  def products(order)
    begin
      to_string(::Checkout::OrderTotals.new(order: order).items)
    rescue ::Checkout::OrderTotals::MissingCartError, ::Checkout::OrderTotals::NoItemsInCart => e
      []
    end
  end

  def format_orders(orders)
    orders.map{ |o| {order: format_order(o), items: products(o) } }
  end

end
