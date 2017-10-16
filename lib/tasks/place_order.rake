require 'business_time'

namespace :place_order do
  if Date.today.workday?
    OrderMailer.place_order.deliver!
  end
end
