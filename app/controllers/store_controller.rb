class StoreController < ActionController::Base
  include StoreHelper

  def index
    @products = product_information(Product.all, session[:cart_id])
  end

end
