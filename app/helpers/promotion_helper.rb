module PromotionHelper
  def promotion_description(promotion)
    discount = promotion.discount
    discount_string = ""

    case 
    when discount.to_f < 1
      amount = (discount.to_f*100).round(0)
      discount_string = "get #{amount}\% off"
    else
      amount = discount.to_f.round(0)
      discount_string = "get $#{amount} off"
    end

    minimum_amount_string = ""
    amount = promotion.minimum_order.to_f.round(0)

    minimum_amount_string = amount > 0 ? " your first order of $#{amount.to_s} or more" : ""

    "Shop at www.iheartmeat.com/steaks and use promo code #{promotion.code.upcase} to " + discount_string + minimum_amount_string + "."
  end
end
