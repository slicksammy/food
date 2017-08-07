# this controller needs to locked down so only the app can access it
# maybe give the cart a uuid
require 'checkout/order_totals'

class CartController < SessionsController
  include StoreHelper

  before_action :create_cart, only: [:update]

  def view
    # check if there is anything in the cart before showing to customer
    if cart && products.any?
      @products = product_information(products, cart_uuid)
      @subtotal = subtotal.to_s

      render 'view', status: 202
    else
      @message = "Your cart is empty"

      render :file => 'public/nothing_here.html.erb', :status => :not_found, :layout => 'bootstrap'
    end
  end

  def update
    product_uuid = params["product_id"]
    
    amount = params["amount"]

    CartsProduct.find_or_create_by(cart_uuid: cart_uuid, product_uuid: product_uuid).update_attributes!(amount: amount)

    render body: nil, status: 202
  end

  def get_subtotal
    render json: { subtotal: subtotal }, status: 202
  end

  def subtotal
    ::Checkout::OrderTotals.new(cart: cart).get_totals[:subtotal].to_s
  end

  def count
    count = cart ? cart.active_carts_products.sum(&:amount) : 0
    
    render json: { count: count }, status: 202
  end

  private

  def create_cart
    unless cart_uuid
      c = Cart.create!(user: current_user)
      session[:cart_uuid] = c.uuid
    end
  end

  def products
    cart.active_products
  end
end
