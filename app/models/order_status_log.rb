class OrderStatusLog < ActiveRecord::Base
  belongs_to :order, primary_key: :uuid, foreign_key: :order_uuid

  scope :ordered, -> { order("created_at DESC") }
end
