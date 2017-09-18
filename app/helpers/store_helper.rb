module StoreHelper
  def product_info(product, cart_uuid)
    amount = 0

    if cart = Cart.find_by_uuid(cart_uuid)
      amount = cart.carts_products.find_by_product_uuid(product.uuid).try(:amount) || 0
    end

    {   
      uuid: product.uuid,
      name: product.name,
      description: product.description,
      price: product.price.to_s,
      image_url: product.image_url,
      amount: amount,
      r_price: product.r_price.to_s
    }
  end

  def product_information(products, cart_uuid)
    products.map{ |p| product_info(p, cart_uuid) }.flatten
  end
end
