# this controller needs to locked down so only the app can access it
# maybe give the cart a uuid
class CartController < ActionController::Base
  include CartHelper

  # before_action :cart_id_present?, except: [:view, :add]

  # UPDATE THESE TO USE UUIDS

  before_action :create_cart

  def create_cart
    unless session[:cart_uuid]
      c = Cart.create!
      session[:cart_uuid] = c.uuid
    end
  end

  def view
    @products = product_info(session[:cart_uuid])
  end

  def update
    product_uuid = params["product_id"]
    
    amount = params["amount"]

    pp = CartsProduct.find_or_create_by(cart_uuid: cart_uuid, product_uuid: product_uuid).update_attributes!(amount: amount)

    render body: nil, status: 202
  end

  def test
    @products = Cart.last.products
  end

  private

  def cart_uuid
    session[:cart_uuid]
  end
end
