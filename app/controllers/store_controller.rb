class StoreController < SessionsController
  include StoreHelper

  # at some point you should have a smart sorting algorithm
  # this includes show products a customer has already ordered and let them reorder

  def index
    @products = product_information(Product.active, cart_uuid)
    @signed_in = current_user_uuid.present? ? true : false
  end

  def packages
    @packages = package_info(Package.active)
  end
end
