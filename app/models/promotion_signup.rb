class PromotionSignup < ActiveRecord::Base
  belongs_to :promotion

  before_save :set_promotion!, if: ->(obj) { !obj.promotion.present? }
  validates :email, presence: true

  def set_promotion!
    self.promotion = self.class.default_promotion
  end

  def self.default_promotion
    @@promotion ||= Promotion.find_by_code('iheartmeat2017')
  end

  def self.create_with_promotion_code!(email, promotion_code, session_id)
    self.create!(email: email, promotion: Promotion.find_by_code(promotion_code), session_id: session_id)
  end
end
