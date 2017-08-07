class UserMailer < ActionMailer::Base
  default from: "support@iheartmeat.com"

  def forgot_password(token)
    @url = 'https://www.iheartmeat.com/reset_password?token=' + token.uuid
    user = token.user
    @name = user.full_name
    mail(to: user.email, subject: 'Password Reset Instructions')
  end
end
