# this controller needs to locked down so only the app can access it
# maybe give the cart a uuid
class CartController < ActionController::Base
  include CartHelper

  # before_action :cart_id_present?, except: [:view, :add]

  # UPDATE THESE TO USE UUIDS

  def view
    @products = product_info(session[:cart_id])
  end

  def update
    product_id = params["product_id"]
    amount = params["amount"]

    pp = CartsProduct.find_or_create_by(cart_id: cart_id, product_id: product_id).update_attributes!(amount: amount)

    render nothing: true, status: 202
  end

  def test
    @products = Cart.last.products
  end

  def cart_id
    session[:cart_id]
  end
end
