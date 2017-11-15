require 'env'

class UserMailer < ActionMailer::Base
  include PromotionHelper

  attr_reader :to, :from

  # TODO update this email
  SUPPORT_EMAIL = 'iheartmeat <support@iheartmeat.com>'
  SAM_EMAIL = 'sam@iheartmeat.com'

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

    mail(from: SUPPORT_EMAIL, to: to, subject: 'Password Reset Instructions')
  end

  def welcome(user)
    to = user.email
    @name = user.first_name

    mail(from: SUPPORT_EMAIL, to: to, bcc: SUPPORT_EMAIL, subject: 'Welcome to iheartmeat')
  end

  def holidays(user)
    return unless user.marketing_opt_in?

    to = user.email
    @name = user.first_name

    mail(from: SUPPORT_EMAIL, to: to, bcc: SUPPORT_EMAIL, subject: 'iheartmeat - The Holidays Are Coming Up')
  end

  def social_media(user)
    return unless user.marketing_opt_in?

    to = user.email
    @name = user.first_name

    mail(from: SUPPORT_EMAIL, to: to, bcc: SUPPORT_EMAIL, subject: 'iheartmeat - We\'re on Social Media')
  end

  def promotion_signup(promotion_signup)
    @promotion_language = promotion_description(promotion_signup.promotion)
    to = promotion_signup.email

    mail(from: SUPPORT_EMAIL, to: to, bcc: SUPPORT_EMAIL, subject: 'iheartmeat - your special offer')
  end
end
