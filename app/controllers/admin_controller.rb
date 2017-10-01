require 'checkout/order_totals'
require 'stats'

class AdminController < SessionsController
  include CheckoutHelper

  before_action :authorize!

  before_action :stats, only: [:dashboard, :get_stats]

  def authorize!
    redirect_to '/' unless admin?
  end

  def index
    orders = Order.all
    @orders = format_orders(orders)
  end

  def dashboard
    # view
  end

  def stats
    i = Stats.new(params["time"] || 60)
    @stats = { orders: i.orders, users: i.users, carts: i.carts, page_views: i.page_views }
  end

  def get_stats
    render json: { stats: @stats }
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
