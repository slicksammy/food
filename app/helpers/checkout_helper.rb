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


end
