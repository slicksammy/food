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
  L_L_EMAIL = 'orderdesk@worldsbeststeak.com'

  layout 'bootstrap'

  def order_confirmation(order)
    @order = format_order(order)
    @user = order.user
    # TODO update support name in google to iheartmeat
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to, bcc: SAM_EMAIL, subject: "iheartmeat order ##{@order[:order_number]}")
  end

  def place_order(orders=Order.paid.for_today)
    @orders = orders.map { |order| {order_number: order.order_number, items: to_string(::Checkout::OrderTotals.new(order: order).items)} }

    mail(from: SAM_EMAIL, to: L_L_EMAIL , cc: [JOEL_EMAIL, SAM_EMAIL], subject: "Orders for Today")
  end

  def delivered(order, note: nil)
    @order = format_order(order)
    @user = order.user
    @note = note
    # TODO update support name in google to iheartmeat
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to , bcc: SAM_EMAIL, subject: "iheartmeat - your order has been delivered!")
  end

  def continue_order(order)
    return unless order.ongoing?

    @user = order.user

    mail(from: SUPPORT_EMAIL, to: @user.email , bcc: SAM_EMAIL, subject: "iheartmeat - order in progress")
  end

end
