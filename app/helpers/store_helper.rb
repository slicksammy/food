module StoreHelper
  def product_info(product, cart_id)
    amount = Cart.find(cart_id).carts_products.find_by_product_id(product.id).try(:amount) || 0

    {   
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      image_url: product.image_url,
      amount: amount
    }
  end

  def product_information(products, cart_id)
    products.map{ |p| product_info(p, cart_id) }.flatten
  end
end
