class ApplicationController < SessionsController
  include CheckoutHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :permit_page_visit_params, only: [:record_page_visit]

  def index
    
  end

  def orders
    @orders = Order.paid.for_today.map { |order| {order_number: order.order_number, items: to_string(::Checkout::OrderTotals.new(order: order).items)} }
    
    render :file => 'order_mailer/place_order.html.erb'
  end

  # TODO remove session info from here
  def version
    render status: 200, json: { version: 1.2, user: session[:user_uuid] }
  end

  def routing_error
    @message = 'Woops! This page does not exist.'

    render :file => 'public/nothing_here.html.erb', status: 500
  end

  def record_page_visit
    PageVisit.create!(url: params["url"], user_uuid: current_user_uuid, ip_address: request.remote_ip, session_id: session[:session_id], referrer: params["referrer"], user_agent: request.user_agent)
    
    render body: nil
  end

  def permit_page_visit_params
    params.permit(:url, :referrer)
  end

end
