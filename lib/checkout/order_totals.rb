require_relative 'apply_promo'

module Checkout
  class OrderTotals

    class MissingCartError < StandardError
    end

    class NoItemsInCart < StandardError
    end

    attr_reader :cart, :user, :order

    def initialize(cart: nil, order: nil)
      @cart = cart || order.try(:cart)
      @order = order || cart.try(:order)

      raise OrderTotals::MissingCartError unless @cart
      raise OrderTotals::NoItemsInCart if carts_products.empty?
    end

    # main method
    # return these values and then can save into order object
    def get_totals
      { subtotal: subtotal, tax: tax, total: total, shipping: shipping, discount: discount}
    end

    def carts_products
      cart.active_carts_products
    end

    def products
      cart.active_products
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

    def discount
      return 0 unless @order
      order = ::Checkout::ApplyPromo.new(@order).validate_promotion(subtotal)
      @discount ||= order.discount
    end

    def subtotal
      @subtotal ||= items.sum{ |p| p[:total] }
    end

    def tax
      taxable = subtotal
      taxable -= discount if discount.present?
      taxable*0.1025
    end

    def total
      total = (tax + subtotal + shipping)
      total -= discount if discount.present?
      total
    end

    def shipping
      4.99.to_money
    end
  end
end
