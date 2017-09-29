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
    # TODO change sam@brokolly below to 'to'
    to = @user.email

    mail(from: SUPPORT_EMAIL, to: to , subject: 'Order Confirmation', bcc: SUPPORT_EMAIL)
  end

end
