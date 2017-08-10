class Admin < ActiveRecord::Base
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid
end
