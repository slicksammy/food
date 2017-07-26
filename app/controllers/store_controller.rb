class StoreController < ActionController::Base
  include StoreHelper

  # at some point you should have a smart sorting algorithm
  # this includes show products a customer has already ordered and let them reorder
  def index
    @products = product_information(Product.all, cart_uuid)
  end

  private

  def cart_uuid
    session[:cart_uuid]
  end

end
