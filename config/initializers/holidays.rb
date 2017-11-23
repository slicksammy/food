# require 'holidays'

# start = Date.new(2016, 1, 1)

# holidays = Holidays.between(start, 5.years.from_now, :us, :observed)

# holidays.each do |holiday|
#   BusinessTime::Config.holidays << holiday[:date]
#   # Implement long weekends:
#   BusinessTime::Config.holidays << holiday[:date].next_week if !holiday[:date].weekday?
# end

HOLIDAYS = ["Thursday, November 23, 2017", "Monday, December 25, 2017", "January 1, 2018"]

HOLIDAYS.each do |holiday|
  BusinessTime::Config.holidays << Date.parse(holiday)
end
