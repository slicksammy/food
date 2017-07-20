class StripeToken < ActiveRecord::Base

  def make_active_and_others_inactive!
    all = StripeToken.where(user_id: self.user_id)
    all.each { |a| a.deactivate! }
    self.activate!
  end

  def deactivate!
    self.active = false
    self.save!
  end

  def activate!
    self.active = true
    self.save!
  end
end
