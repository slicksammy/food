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
    #@url = 'www.heroku.com'
    mail(from: 'sam@brokolly.com', to: 'sam@brokolly.com', subject: 'Password Reset Instructions')
  end
end
