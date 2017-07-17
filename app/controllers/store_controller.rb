class StoreController < ActionController::Base

  def index
    @products = Product.all
  end

end
