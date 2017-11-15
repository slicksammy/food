class UserMailerPreview < ActionMailer::Preview
  #http://localhost:3000/rails/mailers/user_mailer/holidays
  def holidays
    UserMailer.holidays(User.last)
  end

  def social_media
    UserMailer.social_media(User.last)
  end

  def promotion_signup
    UserMailer.promotion_signup(PromotionSignup.last)
  end
end
