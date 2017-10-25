class PageVisit < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  scope :ordered, -> { order("created_at ASC") }
end
