class StoreController < SessionsController
  include StoreHelper

  # at some point you should have a smart sorting algorithm
  # this includes show products a customer has already ordered and let them reorder

  

  def index
    @steaks = product_information(Product.active.first(2), cart_uuid)
    # @signed_in = current_user_uuid.present? ? true : false
    @show_modal = !logged_in?
  end

  def index2
    @steaks = Product.active.first(2)
    @steaks << Product.active.first(4).last
    @product_snapshot = product_information(@steaks, cart_uuid)
  end

  def products
    @products = product_information(Product.active, cart_uuid)

    @show_modal = !logged_in?
  end

  def packages
    @packages = package_info(Package.active)
  end
end
