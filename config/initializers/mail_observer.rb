class MailObserver
  def self.delivered_email(message)
    # puts message.to_s
    message.to.each do |email|
      EmailLog.create!(email: email, subject: message.subject)
    end
  end
end

ActionMailer::Base.register_observer(MailObserver)
