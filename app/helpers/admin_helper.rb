module AdminHelper
  def format_orders
  end

  def products(order)
    
  end

  def format_label(order)
    addr = order.address
    address = "#{addr.street_number} #{addr.street_name.capitalize}"
    address += " ##{addr.address_2}" if addr.address_2
    city_state_zip = "#{addr.city}, #{addr.state} #{addr.zip}"

    {
      name: order.user.full_name,
      order: order.order_number,
      address: address,
      city_state_zip: city_state_zip
    }
  end


end
