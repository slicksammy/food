require 'env'
require 'checkout/order_totals'

class OrderMailer < ActionMailer::Base
  include CheckoutHelper

  attr_reader :to, :from

  # TODO update this email
  # DEFAULT_FROM = 'sam@brokolly.com'
  SUPPORT_EMAIL = 'support@iheartmeat.com'
  SAM_EMAIL = 'sam@iheartmeat.com'
  JOEL_EMAIL = 'joel@worldsbeststeak.com'

  layout 'bootstrap'

  def order_confirmation(order)
    @order = format_order(order)
    @user = order.user
    # TODO update support name in google to iheartmeat
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to , subject: "iheartmeat order ##{@order[:order_number]}")
  end

  def place_order(orders=Order.paid.for_today)
    @orders = orders.map { |order| {order_number: order.order_number, items: to_string(::Checkout::OrderTotals.new(order: order).items)} }

    mail(from: SAM_EMAIL, to: JOEL_EMAIL, cc: SAM_EMAIL, subject: "Orders for today")
  end

  def delivered(order, note: nil)
    @order = format_order(order)
    @user = order.user
    @note = note
    # TODO update support name in google to iheartmeat
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to , subject: "iheartmeat - your order has been delivered!")
  end

end
