module Checkout
  class Order

    attr_reader :cart

    def initialize(cart_uuid)
      @cart = Cart.find cart_uuid
    end

    def carts_products
      @carts_products = cart.active_carts_products
    end

    def products
      @products = cart.active_products
    end

    # helper method can be moved to helper at some point but it requires a lot of the same objects
    def items
      @items = products.map { |p|
        amount = carts_products.find { |cp| cp.product_uuid == p.uuid }.amount
        {
          amount: amount,
          price: p.price,
          name: p.name,
          total: amount*p.price
        }
      }
    end

    def subtotal
      items.sum{ |p| p[:total] }.round(2)
    end

    def tax
      (subtotal*0.1).round(2)
    end

    def total
      (tax + subtotal).round(2)
    end

    def shipping
      0
    end
  end
end
