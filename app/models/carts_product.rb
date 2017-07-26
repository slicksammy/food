class CartsProduct < ActiveRecord::Base
  belongs_to :cart, foreign_key: :cart_uuid
  has_one :product, primary_key: :product_uuid, foreign_key: :uuid
end
