module Checkout
  class OrderTotals

    class MissingCartError < StandardError
    end

    attr_reader :cart, :user, :order

    def initialize(cart: nil, order: nil)
      @cart = cart || order.try(:cart)

      raise OrderTotals::MissingCartError unless @cart
    end

    # main method
    # return these values and then can save into order object
    def get_totals
      { subtotal: subtotal, tax: tax, total: total, shipping: shipping}
    end

    def carts_products
      @carts_products = cart.active_carts_products
    end

    def products
      @products = cart.active_products
    end

    # helper method can be moved to helper at some point but it requires a lot of the same objects
    def items
      @items = carts_products.map { |cp|
        {
          amount: cp.amount,
          price: cp.product.price,
          name: cp.product.name,
          description: cp.product.description,
          image: cp.product.image_url,
          total: cp.amount*cp.product.price
        }
      }
    end

    def subtotal
      items.sum{ |p| p[:total] }
    end

    def tax
      (subtotal*0.1)
    end

    def total
      (tax + subtotal)
    end

    def shipping
      0
    end
  end
end
