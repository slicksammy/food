require 'env'

class OrderMailer < ActionMailer::Base
  include CheckoutHelper

  attr_reader :to, :from

  # TODO update this email
  DEFAULT_FROM = 'sam@brokolly.com'

  layout 'bootstrap'

  def order_confirmation(order)
    @order = format_order(order)
    @user = order.user
    
    # TODO change sam@brokolly below to 'to'
    to = @user.email

    mail(from: DEFAULT_FROM, to: to , subject: 'Order Confirmation')
  end

end
