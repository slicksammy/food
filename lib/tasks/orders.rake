require 'business_time'

task :place_order => :environment do
  if Date.today.workday?
    OrderMailer.place_order.deliver!
  end
end

task :email_ongoing_orders => :environment do
  Order.ongoing.in_the_last_hours(24).each do |o|
    OrderMailer.continue_order(o).deliver!
  end
end

task :set_products => :environment do
  Order.completed.each do |o|
    o.set_products
    o.save!
  end
end

