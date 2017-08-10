require 'env'

class UserMailer < ActionMailer::Base

  attr_reader :to, :from

  DEFAULT_FROM = 'sam@brokolly.com'

  layout 'bootstrap'

  # def password_reset(token)
  #   @url = 'http://www.iheartmeat.com/reset_password?token=' + token.uuid
  #   subject = 'Password Reset Instructions'

  #   params = {
  #     to: to,
  #     from: from,
  #     subject: subject,
  #     html: File.read('app/views/mailers/user_mailer/_password_reset.html.erb')
  #   }

  #   deliver!(params)
  # end
  def password_reset(token)
    @url = "#{Env.base_uri}/reset_password?token=#{token.uuid}"
    to = token.user.email

    mail(from: DEFAULT_FROM, to: to, subject: 'Password Reset Instructions')
  end

  def welcome(user)
    to = user.email
    @name = user.full_name

    mail(from: DEFAULT_FROM, to: to, subject: 'Welcome to IHeartMeat')
  end
end
