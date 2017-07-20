module CartHelper
  def product_info(cart_id)
    cart = Cart.find(cart_id)
    carts_products = cart.carts_products
    products = cart.active_products

    products.map { |p|
      { 
        id: p.id,
        name: p.name,
        price: p.price,
        amount: carts_products.find_by_product_id(p.id).amount,
        image_url: p.image_url
      }
    }
  end
end
