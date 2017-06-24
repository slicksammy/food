class Note < ActiveRecord::Base

  scope :ordered, -> { order("created_at DESC") }

  validates :note_text, presence: true
end
