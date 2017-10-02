class OrderMailerPreview < ActionMailer::Preview
  def place_order
    OrderMailer.place_order
  end
end
