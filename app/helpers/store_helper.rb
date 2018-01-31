module StoreHelper
  def product_info(product, cart_uuid)
    amount = 0

    if cart = Cart.find_by_uuid(cart_uuid)
      amount = cart.carts_products.find_by_product_uuid(product.uuid).try(:amount) || 0
    end

    product_hash(product, amount)
  end

  def product_information(products, cart_uuid)
    products.map{ |p| product_info(p, cart_uuid) }.flatten
  end

  def package_info(packages)
    pkgs = []

    packages.each do |package|
      products = package.products
      data = {}
      data[:products] = products.map { |p| product_hash(Product.find_by_uuid(p[:uuid]), p[:amount]) }
      data[:name] = package.package_name
      data[:price] = package.price.to_s
      data[:regular_price] = package.regular_price.to_s
      data[:discount] = ((1- package.price / package.regular_price)*100).round(0)
      data[:description] = package.description
      data[:uuid] = package.uuid
      pkgs << data
    end

    pkgs
  end

  def product_hash(product, amount)
    {   
      uuid: product.uuid,
      name: product.name,
      description: product.description,
      price: product.price.to_s,
      image_url: product.image_url,
      amount: amount,
      r_price: product.r_price.to_s,
      regular_price: product.regular_price.to_s,
      regular_price_discount: ((1 - (product.price / product.regular_price))*100).round(0),
      promotional: product.promotional
    }
  end
end
