class Promotion < ActiveRecord::Base

  monetize :minimum_order_cents

  def self.find_by_code(code)
    return nil unless code
    all.find { |a| a.code.downcase == code.downcase }
  end
end
