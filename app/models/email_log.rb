class EmailLog < ActiveRecord::Base
  scope :email_in_the_last_hours, ->(email, hours) { where("email = ? and created_at > current_timestamp - interval '? hours'", email, hours)}
end
