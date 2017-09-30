module Checkout
  class ApplyPromo

    attr_accessor :order
    attr_reader :code, :promo

    def initialize(order)
      @order = order
    end

    def apply_promotion(promo_code)
      @promo = Promotion.find_by_code(promo_code)
      @code = promo_code

      return { error: 'discount already added to your order' } if order.discounted?
      return { error: 'promotion code is invalid' } unless promo

      return { error: 'promotion has expired' } if expired?
      return { error: "order does not meet minimum subtotal of $#{promo.minimum_order}" } unless meets_minum_order?(order.subtotal)

      order.promotion = promo
      order.discount = discount
      order.save!
      order.reload

      { success: true, order: order }
    end

    def validate_promotion(subtotal)
      return order unless order.promotion

      @promo = order.promotion

      if !expired? && meets_minum_order?(subtotal)
        nil
      else
        order.discount = 0
        order.promotion = nil
        order.save!
        order.reload
      end

      order
    end

    def expired?
      !!promo.expired
    end

    def meets_minum_order?(subtotal)
      subtotal >= promo.minimum_order
    end

    def discount
      discount = promo.discount

      case
      when discount == "free shipping"
        order.shipping
      # make sure there is no typo to give customer more than 30% off
      when 0.3 < discount.to_f && discount.to_f < 1
        nil
      when discount.to_f < 0.3
        order.subtotal * discount.to_f
      when discount.to_f > 1
        discount.to_f
      end
    end
  end
end

