require 'business_time'

task :place_order => :environment do
  if Date.today.workday?
    OrderMailer.place_order.deliver!
  end
end
