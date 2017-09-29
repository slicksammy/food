require 'env'

class OrderMailer < ActionMailer::Base
  include CheckoutHelper

  attr_reader :to, :from

  # TODO update this email
  # DEFAULT_FROM = 'sam@brokolly.com'
  SUPPORT_EMAIL = 'support@iheartmeat.com'

  layout 'bootstrap'

  def order_confirmation(order)
    @order = format_order(order)
    @user = order.user
    # TODO update support name in google to iheartmeat
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to , subject: "iheartmeat order ##{@order[:order_number]}")
  end

end
