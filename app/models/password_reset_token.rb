require 'uuid_helper'

class PasswordResetToken < ActiveRecord::Base
  include UUIDHelper
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  def is_valid?
    true
    #created_at > 24.hours.ago && !used
  end

  def use!
    self.used = true
    self.save!
  end

  def update_users_password!(password)
    user.update_password!(password)
    self.use!
  end
  
end
