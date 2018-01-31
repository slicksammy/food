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

    @main_pic = "assets/home_images/rawsteaks.jpg"

    if params["pic"]
      if File.file?(Rails.root + 'app/assets/images/home_images' + "#{params["pic"]}.jpg")
        @main_pic = 'assets/home_images/' + params["pic"] + ".jpg"
      elsif File.file?(Rails.root + 'app/assets/images/home_images' + params["pic"] + "png")
        @main_pic = 'assets/home_images/' + params["pic"] + ".png"
      end
    end

    add_promotional_product_to_cart
  end

  def products
    @products = product_information(Product.active, cart_uuid)

    @show_modal = !logged_in?
  end

  def packages
    @packages = package_info(Package.active)
  end

  def add_promotional_product_to_cart
    unless cart_uuid
      c = Cart.create!(user: current_user, session_id: session[:session_id])
      c.add_product(Product.promotional_product, 1)
      session[:cart_uuid] = c.uuid
    end
  end
end
