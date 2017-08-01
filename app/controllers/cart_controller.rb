# this controller needs to locked down so only the app can access it
# maybe give the cart a uuid
require 'checkout/order_totals'

class CartController < ActionController::Base
  include StoreHelper

  before_action :create_cart, only: [:update]

  def view
    # check if there is anything in the cart before showing to customer
    if cart_uuid && products.any?
      @products = product_information(products, session[:cart_uuid])
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

    pp = CartsProduct.find_or_create_by(cart_uuid: cart_uuid, product_uuid: product_uuid).update_attributes!(amount: amount)

    render body: nil, status: 202
  end

  def get_subtotal
    render json: { subtotal: subtotal }, status: 202
  end

  def subtotal
    ::Checkout::OrderTotals.new(cart).get_totals[:subtotal].to_s
  end

  private

  def create_cart
    unless session[:cart_uuid]
      c = Cart.create!
      session[:cart_uuid] = c.uuid
    end
  end

  def cart_uuid
    session[:cart_uuid]
  end

  def cart
    Cart.find_by_uuid(cart_uuid)
  end

  def products
    cart.active_products
  end
end
