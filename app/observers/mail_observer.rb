class MailObserver
  def self.delivered_email(message)
    puts "observed"
  end
end

ActionMailer::Base.register_observer(MailObserver)
