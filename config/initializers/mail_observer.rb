class MailObserver
  def self.delivered_email(message)
    # puts message.to_s
    EmailLog.create!(email: message.to, subject: message.subject)
  end
end

ActionMailer::Base.register_observer(MailObserver)
