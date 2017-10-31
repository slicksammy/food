class UserMailerPreview < ActionMailer::Preview
  #http://localhost:3000/rails/mailers/user_mailer/holidays
  def holidays
    UserMailer.holidays(User.last)
  end
end
