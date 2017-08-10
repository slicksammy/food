module CheckoutHelper
  def format_addresses(addresses)
    addresses.map{ |a| { value: a.uuid, display: format_address(a) } }
  end

  def format_address(address)
    address.formatted
  end

  def format_payments(payments)
    payments.map{ |a| { value: a.id, display: format_payment(a) } }
  end

  def format_payment(payment)
    "card ending in #{payment.last_4}"
  end

  def to_string(array_of_hashes)
    array_of_hashes.map { |e| e.each {|k,v| e[k] = v.to_s } }
  end

  def format_order(order)
    {
      total: order.total.to_s,
      subtotal: order.subtotal.to_s,
      tax: order.tax.to_s,
      shipping: order.shipping.to_s,
      address_uuid: order.address_uuid,
      stripe_token_uuid: order.stripe_token_uuid,
      expected_delivery_date: order.expected_delivery_date,
      formatted_expected_delivery_date: format_date(order.expected_delivery_date),
      order_number: order.order_number,
      delivered_on: format_date(order.delivered_on),
      status: order.status.try(:capitalize)
    }
  end

  def format_date(date)
    date.try(:strftime, ("%A %B %dth"))
  end

end
