class Note < ActiveRecord::Base

  scope :ordered, -> { order("created_at DESC") }

  scope :search, ->(text) { where("note_text ILIKE ?", "%#{text}%") }

  belongs_to :place

  validates :note_text, presence: true
end
